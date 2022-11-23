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
    private(set) var remainingTime: PublishRelay<String> = .init()
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
                guard let status = self?.getArtworkStatus(error) else { return }
                self?.artwork.accept(status)
            })
            .disposed(by: disposeBag)
    }
    
    func checkRemainingTime(to date: Date) -> Disposable {
        return Observable<Int>
            .interval(.seconds(60),
                      scheduler: MainScheduler.asyncInstance)
            .map { [weak self] _ in
                let today = Date.koreanNowDate
                let comparedDate = self?.getNextQuestionDate(from: today)
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
    
    func getArtworkStatus(_ error: Error) -> WeeklyArtworkStatus? {
        let failedStatus = WeeklyArtworkStatus.failed(error)
        guard case let .failed(error) = failedStatus else {
            return nil
        }
        guard let error = error as? RequestError, error == .noMoreDataError else {
            return failedStatus
        }
        return .noMoreData
    }
    
    // 구현에 고민 필요, 깔끔하게 바꿀 필요성 보임
    func formatDateComponentsToTextString(dateComponents: DateComponents) -> String {
        let day = dateComponents.day
        let hour = dateComponents.hour
        let minute = dateComponents.minute
        let second = dateComponents.second
        
        if let day, day > 0 {
            return "\(day)일"
        } else if let hour, hour > 0 {
            return "\(hour)시간"
        } else if let minute, minute > 0 {
            return "\(minute)분"
        } else if let second, second > 0 {
            return "1분"
        } else {
            return ""
        }
    }
    
    func getNextQuestionDate(from today: Date) -> Date {
        
        let thisWeekSundayQuestionTime = dateHelper.makeDateInSameWeek(with: today, to: .sun, HHmm: "1400")
        let thisWeekSaturdayQuestionTime = dateHelper.makeDateInSameWeek(with: today, to: .sat, HHmm: "1400")
        
        if !today.isLaterDate(than: thisWeekSundayQuestionTime) {
            return thisWeekSundayQuestionTime
        } else if !today.isLaterDate(than: thisWeekSaturdayQuestionTime) {
            return thisWeekSaturdayQuestionTime
        } else {
            let nextWeekSundayQuestionTime = dateHelper.dateAfter(days: 7, from: thisWeekSundayQuestionTime)
            return nextWeekSundayQuestionTime
        }
    }
}

