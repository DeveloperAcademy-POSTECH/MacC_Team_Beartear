//
//  QuestionViewModel.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import RxCocoa
import RxSwift

final class QuestionViewModel {

    private let requestNextArtworkUsecase: RequestNextArtworkUsecase
    private let timeDiffHandler: TimeDiffHandler
    private let dateHelper: DateHelper = .init()
    private let disposeBag: DisposeBag = .init()
    
    private(set) var artwork: BehaviorRelay<WeeklyArtworkStatus> = .init(value: .notRequested)
    private(set) var remainingTime: PublishRelay<RemainingTimeStatus> = .init()
    private(set) var possibleAnsweringNewQuestion: BehaviorRelay<Bool> = .init(value: true)
    
    init(requestNextQuestionUsecase: RequestNextArtworkUsecase,
         timeDiffHandler: TimeDiffHandler = TimeDiffHandler(
            dateComponentsSet: [.day, .hour, .minute, .second])) {
        self.requestNextArtworkUsecase = requestNextQuestionUsecase
        self.timeDiffHandler = timeDiffHandler
    }
    
    func requestArtwork(_ userLastArtworkId: Int) {
        artwork.accept(.loading)
        requestNextArtworkUsecase.requestNextArtwork(userLastArtworkId)
            .subscribe(onNext: { [weak self] in
                let loadedStatus = WeeklyArtworkStatus.loaded($0)
                self?.artwork.accept(loadedStatus)
            },
                       onError: { [weak self] error in
                guard let failedStatus = self?.errorToFailedOrNoData(error) else { return }
                self?.artwork.accept(failedStatus)
            })
            .disposed(by: disposeBag)
    }
    
    // TODO: interval로 인해 요구 기능치고는 너무 많은 소모가 있을 것으로 예상되어 observable stream을 다루는 함수가 아닌 그냥 체크 함수 사용할까 고민
    func checkRemainingTime(to date: Date) -> Disposable {
        return Observable<Int>
            .interval(.seconds(60),
                      scheduler: MainScheduler.asyncInstance)
            .map { [weak self] _ in
                let today = Date()
                let comparedDate = self?.getNextArtworkDate(from: today)
                return (self?.timeDiffHandler.getDateComponentsDiff(from: today, to: comparedDate!))!
            }
            .map { [weak self] in
                (self?.formatDateComponentsToTextString(dateComponents: $0))!
            }
            .subscribe(onNext: { [weak self] in
                self?.remainingTime.accept($0)
            })
    }
}

private extension QuestionViewModel {
    
    func errorToFailedOrNoData(_ error: Error) -> WeeklyArtworkStatus? {
        let failedStatus = WeeklyArtworkStatus.failed(error)
        guard case let .failed(error) = failedStatus else {
            return nil
        }
        guard let error = error as? ArtworkRequestError, error == .noMoreDataError else {
            return failedStatus
        }
        return .noMoreData
    }
    
    // 구현에 고민 필요, 깔끔하게 바꿀 필요성 보임
    func formatDateComponentsToTextString(dateComponents: DateComponents) -> RemainingTimeStatus {
        let day = dateComponents.day
        let hour = dateComponents.hour
        let minute = dateComponents.minute
        let second = dateComponents.second
        
        if let day, day > 0 {
            return .moreThanOneDay(day: day)
        } else if let hour, hour > 0 {
            return .lessThanDayMoreThanHour(hour: hour)
        } else if let minute, minute > 0 {
            return .lessThanOneHour(minute: minute)
        } else {
            return .lessThanOneHour(minute: 1)
        }
    }
    
    func getNextArtworkDate(from today: Date) -> Date {
        
        let thisWeekSundayArtworkTime = dateHelper.makeDateInSameWeek(with: today, to: .sun, HHmmss: "140000")
        let thisWeekSaturdayArtworkTime = dateHelper.makeDateInSameWeek(with: today, to: .sat, HHmmss: "140000")
        
        if today.isEarlierDate(than: thisWeekSundayArtworkTime) {
            return thisWeekSundayArtworkTime
        } else if today.isEarlierDate(than: thisWeekSaturdayArtworkTime) {
            return thisWeekSaturdayArtworkTime
        } else {
            let nextWeekSundayArtworkTime = dateHelper.dateAfter(days: 7, from: thisWeekSundayArtworkTime)
            return nextWeekSundayArtworkTime
        }
    }
}

