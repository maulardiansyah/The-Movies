//
//  mSearchMovie.swift
//  The Movies
//
//  Created by Maul on 07/07/21.
//

struct mSearchMoviesData: Codable {
    let page, totalResults, totalPages: Int?
    let results: [mSearchMovie]?
    
    private enum CodingKeys : String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        case page
    }
}

struct mSearchMovie: Codable {
    let posterPath, overview, releaseDate, originalTitle, originalLanguage: String?
    let title, backdropPath, status: String?
    let id, voteCount: Int?
    let voteAverage: Double
    let adult, video: Bool?
    let budget, revenue, runtime: Int?
    let genres: [mGenre]?
    
    private enum CodingKeys : String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case adult, video, title, id, overview
        case budget, revenue, runtime, status, genres
    }
}
