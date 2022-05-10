//
//  TargetType.swift
//  SwiftNetworkLayer
//
//  Created by Gaurang Vyas on 29/01/22.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol TargetType {

    var baseURL: String { get }

    var path: String { get }

    var method: HttpMethod { get }

    var headers: [String: String] { get }
    
    var task: Task { get }
}

enum Task {
    case plainRequest
    case withRequestModel(requestModel: Convertible, encoding: ApiService.Encoding)
    case withParameters(parameters: [ApiService.ParamKey: Any], encoding: ApiService.Encoding)
}

extension TargetType {
    var fullUrl: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
}
