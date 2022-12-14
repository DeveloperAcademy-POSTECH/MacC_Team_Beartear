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
    private let artworkHelper: ArtworkHelper = .init()
    private let disposeBag: DisposeBag = .init()
    let addReviewInput: PublishRelay<Void> = .init()
    let weeklyArtworkStatusRelay: BehaviorRelay<WeeklyArtworkStatus> = .init(value: .notRequested)
    let artwork: BehaviorRelay<Artwork?> = .init(value: nil)
    private var user: User
    
    init(
        requestNextQuestionUsecase: RequestNextArtworkUsecase = RealRequestNextArtworkUsecase(),
        timeDiffHandler: TimeDiffHandler = TimeDiffHandler(
            dateComponentsSet: [.day, .hour, .minute, .second]),
        user: User
    ) {
        self.user = user
        self.requestNextArtworkUsecase = requestNextQuestionUsecase
        self.timeDiffHandler = timeDiffHandler
        setUpObserver()
    }

    private func setUpObserver() {
        addReviewInput
            .do(onNext: { [unowned self] in
                self.user = User(id: user.id, lastArtworkId: user.lastArtworkId + 1, firstLoginedDate: user.firstLoginedDate)
            })
            .subscribe(onNext: { [unowned self] in
                self.requestArtwork()
            })
            .disposed(by: disposeBag)
    }

    func requestArtwork() {
        weeklyArtworkStatusRelay.accept(.loading)
        requestNextArtworkUsecase.requestNextArtwork(with: user)
            .subscribe(onNext: { [weak self] in
                let loadedStatus = WeeklyArtworkStatus.loaded($0)
                self?.weeklyArtworkStatusRelay.accept(loadedStatus)
                self?.artwork.accept($0)
            },
                       onError: { [weak self] error in
                guard let failedStatus = self?.errorToFailedOrNoData(error) else { return }
                self?.weeklyArtworkStatusRelay.accept(failedStatus)
            })
            .disposed(by: disposeBag)
    }
}

private extension QuestionViewModel {
    
    func checkRemainingTime() -> RemainingTimeStatus {
        let today = Date()
        let comparedDate = artworkHelper.getNextArtworkDate(from: today)
        let diffTimeDateComponents = timeDiffHandler.getDateComponentsDiff(from: today, to: comparedDate)
        let timeStatus = formatDateComponentsToRemainingTimeStatus(dateComponents: diffTimeDateComponents)
        return timeStatus
    }
    
    func errorToFailedOrNoData(_ error: Error) -> WeeklyArtworkStatus? {
        let failedStatus = WeeklyArtworkStatus.failed(error)
        guard case let .failed(error) = failedStatus else {
            return nil
        }
        if case RxFirestoreError.documentIsNotExist = error {
            return .noMoreData
        }
        if let error = error as? ArtworkRequestError, error == .waitNextArtworkError {
            return .waitNextArtworkDay(checkRemainingTime())
        }
        return failedStatus
    }
    
    func formatDateComponentsToRemainingTimeStatus(dateComponents: DateComponents) -> RemainingTimeStatus {
        let day = dateComponents.day
        let hour = dateComponents.hour
        let minute = dateComponents.minute
        
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
}

