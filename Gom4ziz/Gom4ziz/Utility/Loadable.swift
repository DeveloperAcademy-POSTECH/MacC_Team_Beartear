//
//  Loadable.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/30.
//

import Foundation

enum Loadable<T> {
    case notRequested
    case isLoading(last: T?)
    case loaded(T)
    case failed(Error)
}

extension Loadable {

    var isNotRequested: Bool {
        switch self {
        case .notRequested:
            return true
        default:
            return false
        }
    }

    var value: T? {
        switch self {
        case .isLoading(let last):
            return last
        case .loaded(let data):
            return data
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }

    var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }
}

extension Loadable: CustomStringConvertible {
    var description: String {
        switch self {
        case .notRequested:
            return "\(T.self) 아직 요청되지 않음"
        case .isLoading(let last):
            return "\(T.self) 로딩 중임. 이전 데이터: \(String(describing: last))"
        case .loaded(let value):
            return "데이터 로딩 완료: \(value)"
        case .failed(let error):
            return "에러 발생: \(error)"
        }
    }
}

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case (.isLoading(last: let first), .isLoading(last: let second)):
            return first == second
        case (.loaded(let first), .loaded(let second)):
            return first == second
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}

extension Loadable {
    func map<V>(_ transform: (T) throws -> V) -> Loadable<V> {
            do {
                switch self {
                case .notRequested: return .notRequested
                case let .failed(error): return .failed(error)
                case let .isLoading(value):
                    return .isLoading(last: try value.map { try transform($0) })
                case let .loaded(value):
                    return .loaded(try transform(value))
                }
            } catch {
                return .failed(error)
            }
        }
}
