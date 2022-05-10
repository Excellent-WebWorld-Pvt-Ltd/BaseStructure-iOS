//
//  RequestModels.swift
//  BaseStructure
//
//  Created by Gaurang on 03/05/22.
//

import Foundation

// swift
struct RequestModels {
    
    // MARK: - Upcoming
    struct Upcoming: Convertible {
        let apiKey = SessionManager.shared.apiToken
        let page: Int
        let language: String = "en-US"

        enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case page
            case language
        }
    }
}
