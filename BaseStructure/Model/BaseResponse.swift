//
//  BaseModel.swift
//  TatvaSoftPactical
//
//  Created by Gaurang Vyas on 17/03/22.
//

import Foundation

// MARK: - BaseResponse
struct BaseResponse<T: Codable>: Codable {
    let status: Bool
    let message: String?
    let data: T?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}
