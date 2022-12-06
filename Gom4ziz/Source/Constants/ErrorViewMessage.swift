//
//  ErrorViewMessage.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/27.
//

import Foundation

enum ErrorType: String {
    case artwork = "작품"
    case question = "작가의 질문"
    case artworkDescription = "작품 설명"
}

enum ErrorViewMessage {
    case loadFailed(type: ErrorType)
    case noReview
    case networkError(type: ErrorType)
}

extension ErrorViewMessage: Equatable {
    
    var header: String {
        switch self {
        case .loadFailed(let type):
            return "\(type.rawValue)을 불러오지 못했습니다."
        case .noReview:
            return "아직 감상한 작품이 없습니다."
        case .networkError(let type):
            return "\(type.rawValue)을 불러오지 못했습니다."
        }
    }
    
    var description: String {
        switch self {
        case .noReview:
            return "작가의 질문에 답해보고 작품을 감상해보세요"
        case .networkError:
            return "네트워크 연결을 확인하고 다시 시도해주세요."
        default:
            return "아래 버튼을 탭해서 다시 불러와 보세요."
        }
    }
    
}
