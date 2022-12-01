//
//  WeeklyArtworkStatus.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

enum WeeklyArtworkStatus {
    case notRequested
    case loading
    case loaded(Artwork)
    case waitNextArtworkDay(RemainingTimeStatus)
    case noMoreData
    case failed(Error)
}

extension WeeklyArtworkStatus: CustomStringConvertible {
    var description: String {
        switch self {
        case .notRequested:
            return "아직 요청되지 않음"
        case .loading:
            return "로딩중임"
        case .loaded(let data):
            return "\(data) 로드 완료"
        case .waitNextArtworkDay:
            return "더이상 받을 데이터가 없음. 다음 데이터 받는 날 까지 기다려야함"
        case .noMoreData:
            return "서버에 저장되어있는 데이터가 더이상 없음"
        case .failed(let error):
            return "\(error) 종류의 에러 발생 "
        }
    }
}
