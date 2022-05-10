//
//  MoviesListModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation

// MARK: - MoviesList
struct BasePaginationModel<T: Codable>: Codable {
    let page: Int
    let results: T?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
