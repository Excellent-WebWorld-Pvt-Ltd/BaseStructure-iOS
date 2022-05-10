//
//  ApiError.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case requestModelError(_ message: String)
    case urlBuildingError(_ message: String)
    case decodingError(_ message: String)
    case internetUnavailable
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .requestModelError(let message):
            return message
        case .decodingError(let message):
            return message
        case .internetUnavailable:
            return "Internet not available, please check internet connection"
        case .urlBuildingError(let message):
            return message
        case .unauthorized:
            return "Unauthorized user"
        }
    }

    var canRetry: Bool {
        if case .internetUnavailable = self {
            return true
        } else {
            return false
        }
    }
}

extension Error {
    func eraseToApiError() -> ApiError {
        switch self {
        case let apiError as ApiError:
            return apiError
        default:
            return .decodingError(self.localizedDescription)
        }
    }
}
