//
//  ApiServices.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation
import UIKit

class ApiService {
    
    static func call<T: Codable>(_ target: TargetType, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(.internetUnavailable))
            return
        }
        guard let url = target.fullUrl else {
            completion(.failure(.urlBuildingError("Failed to build URL")))
            return
        }
        var request: URLRequest!
        do {
            switch target.task {
            case .plainRequest:
                request = URLRequest(url: url)
            case .withRequestModel(let requestModel, let encoding):
                if encoding == .url {
                    request = try URLRequest(url: requestModel.urlEncoding(url: url))
                } else {
                    request = URLRequest(url: url)
                    request.httpBody = try requestModel.jsonData()
                }
            case .withParameters(let parameters, let encoding):
                if encoding == .url {
                    request = try URLRequest(url: parameters.urlEncoding(url: url))
                } else {
                    request = URLRequest(url: url)
                    request.httpBody = try parameters.jsonData()
                }
            case .multipart(let params, let files):
                let boundary: String = "Boundary-\(UUID().uuidString)"
                request = URLRequest(url: url)
                request.addValue(SessionManager.shared.apiToken, forHTTPHeaderField: "x-api-key")
                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpMethod = HttpMethod.post.rawValue

                let bodyData = createDataBody(boundary: boundary, params: params, files: files)
                request.httpBody = bodyData
            }
        } catch let error as ApiError {
            completion(.failure(error))
            return
        } catch {
            completion(.failure(.urlBuildingError(error.localizedDescription)))
            return
        }
        request.httpMethod = target.method.rawValue
        if case .multipart = target.task {
            // Header already added for multipart
        } else {
            for (key, value) in target.headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard self.checkResponseStatus(response: response) else {
                    return
                }
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                       /* jsonDecoder.dateDecodingStrategy = .formatted(DateFormatHelper.apiFormat.dateFormatter)*/
                        let baseModel = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(baseModel))
                    } catch let error {
                        print("Api Error for \(request.url!.lastPathComponent): ", error.localizedDescription)
                        completion(.failure(.decodingError(error.localizedDescription)))
                    }
                } else if let error = error {
                    print("Api Error for \(request.url!.lastPathComponent): ", error.localizedDescription)
                    completion(.failure(.decodingError("Something Went Wrong")))
                }
            }

        }.resume()
    }
    
    static func checkResponseStatus(response: URLResponse?) -> Bool {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 403 {
                let action = UIAlertAction(title: StringConsts.okay, style: .default) { _ in
                    SessionManager.shared.logout()
                }
                ThemeAlertView.show(title: StringConsts.alert, message: Messages.sessionExpired, actions: [action])
                return false
            } else {
                return true
            }
        }
        return false
    }
}

extension ApiService {
    
    enum ParamKey: String {
        case userId = "user_id"
        case page
        case query
        case apiKey = "api_key"
    }
    
    enum Encoding {
        case url
        case json
    }
    
    static let commonHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
}

extension ApiService {
    static func createDataBody(boundary: String, params: [String: Any], files: [MimeTypes]) -> Data {

        let lineBreak = "\r\n"
        var body = Data()
        print(params)
        for (key, value) in params {
            if let strValue = value as? String {
                body.appendString("--\(boundary + lineBreak)")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.appendString("\(strValue + lineBreak)")
            } else {
                if let array = value as? [Any], array.isEmpty {
                    continue
                } else if let theJSONData = try? JSONSerialization.data(withJSONObject: value, options: []),
                              let theJSONText = String(data: theJSONData, encoding: .utf8) {
                        body.appendString("--\(boundary + lineBreak)")
                        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                        body.appendString("\(theJSONText + lineBreak)")
                }
            }
        }
        for file in files {
            body.appendString("--\(boundary + lineBreak)")
            // swiftlint:disable line_length
            body.appendString("Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.fileName)\"\(lineBreak)")
            // swiftlint:enable line_length
            body.appendString("Content-Type: \(file.mimeType + lineBreak + lineBreak)")
            body.append(file.data)
            body.appendString(lineBreak)
        }
        body.appendString("--\(boundary)--\(lineBreak)")

        return body
    }
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8)
        append(data!)
    }
}
