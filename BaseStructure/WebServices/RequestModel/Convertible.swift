//
//  Convertable.swift
//  Populaw
//
//  Created by Gaurang on 22/10/21.
//

import Foundation

protocol Convertible: Encodable {

}

extension Convertible {

    // implement convert Struct or Class to Dictionary
    func convertToDict() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        if let dict = result as? [String: Any] {
            return dict
        } else {
            throw ApiError.requestModelError("Failed to convert json object into [String: String]")
        }
    }
    
    func urlEncoding(url: URL) throws -> URL {
        let params = try convertToDict()
        let urlStr = url.absoluteString
        var urlComponents = URLComponents(string: urlStr)!
        if !params.isEmpty {
            urlComponents.queryItems = params.compactMap({
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
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
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
