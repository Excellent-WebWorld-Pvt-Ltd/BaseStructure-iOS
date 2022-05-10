//
//  MovieInfoModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation
// MARK: - Result
struct MovieInfoModel: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try? values.decode(Bool.self, forKey: .adult)
        backdropPath = try? values.decode(String.self, forKey: .backdropPath)
        genreIDS = try? values.decode([Int].self, forKey: .genreIDS)
        id = try values.decode(Int.self, forKey: .id)
        originalLanguage = try? values.decode(String.self, forKey: .originalLanguage)
        originalTitle = try? values.decode(String.self, forKey: .originalTitle)
        overview = try? values.decode(String.self, forKey: .overview)
        popularity = try? values.decode(Double.self, forKey: .popularity)
        posterPath = try? values.decode(String.self, forKey: .posterPath)
        releaseDate = try? values.decode(String.self, forKey: .releaseDate)
        title = try? values.decode(String.self, forKey: .title)
        video = try? values.decode(Bool.self, forKey: .video)
        voteAverage = try? values.decode(Double.self, forKey: .voteAverage)
        voteCount = try? values.decode(Int.self, forKey: .voteCount)
    }
}
