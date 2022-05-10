//
//  AppEnvironment.swift
//  MVVMDemo
//
//  Created by Gaurang on 02/09/21.
//

import Foundation

enum AppEnvironmentType: String {
    case development
    case production
}

extension AppEnvironmentType {
    var hostUrl: String {
        switch self {
        case .development   :  return "https://api.themoviedb.org/3/"
        case .production    :  return "https://api.themoviedb.org/3/"
        }
    }
    
    var socketUrl: String {
        switch self {
        case .development   :   return "https://api.themoviedb.org/3/"
        case .production    :   return "https://api.themoviedb.org/3/"
        }
    }
}

class AppEnvironment {
    static let shared = AppEnvironment()
    lazy var environment: AppEnvironmentType = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "development") != nil {
                return AppEnvironmentType.development
            }
        }
        return AppEnvironmentType.production
    }()

    static var hostUrl: String {
        AppEnvironment.shared.environment.hostUrl
    }

    static var apiUrl: String {
        AppEnvironment.shared.environment.hostUrl
    }
    
    static var socketUrl: String {
        AppEnvironment.shared.environment.socketUrl
    }
    
    static var imageBasePath: String {
        "https://image.tmdb.org/t/p/w500"
    }
}
