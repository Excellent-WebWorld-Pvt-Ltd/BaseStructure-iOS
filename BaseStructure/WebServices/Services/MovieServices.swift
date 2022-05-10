//
//  MoviewServices.swift
//  SwiftNetworkLayer
//
//  Created by Gaurang Vyas on 30/01/22.
//

import Foundation

enum MovieServices {
    case upcoming(page: Int)
    case details(id: Int)
    case search(term: String)
}

extension MovieServices: TargetType {
    
    var baseURL: String {
        AppEnvironment.apiUrl + "movie"
    }
    
    var path: String {
        switch self {
        case .upcoming:
            return "upcoming"
        case .details(let id):
            return "\(id)"
        case .search:
            return "search"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .upcoming, .details:
            return .get
        case .search:
            return .post
        }
    }
    
    var headers: [String: String] {
        ApiService.commonHeaders
    }
    
    var task: Task {
        switch self {
        case .upcoming(let page):
            return .withRequestModel(requestModel: RequestModels.Upcoming(page: page), encoding: .url)
        case .search(let term):
            return .withParameters(parameters: [.query: term], encoding: .json)
        case .details:
            return .withParameters(parameters: [.apiKey: SessionManager.shared.apiToken], encoding: .url)
        }
    }
    
}
