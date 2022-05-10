//
//  ParametersConvertible.swift
//  SwiftNetworkLayer
//
//  Created by Gaurang Vyas on 30/01/22.
//

import Foundation

protocol ParameterConvertible {
    func urlEncoding(url: URL) throws -> URL
    func jsonData() throws -> Data
}

extension Dictionary: ParameterConvertible where Key == ApiService.ParamKey, Value == Any {
    func urlEncoding(url: URL) throws -> URL {
        let urlStr = url.absoluteString
        var urlComponents = URLComponents(string: urlStr)!
        if !self.isEmpty {
            urlComponents.queryItems = self.compactMap({
                URLQueryItem(name: $0.key.rawValue, value: String(describing: $0.value))
            })
        }
        if let finalURL = urlComponents.url {
            print(finalURL)
            return finalURL
        } else {
            throw(ApiError.urlBuildingError("Error occure during building url components - \(urlStr)"))
        }
    }
    
    func jsonData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
