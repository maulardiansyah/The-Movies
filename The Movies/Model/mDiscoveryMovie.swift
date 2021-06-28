//
//  mDiscoveryMovie.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

struct mDiscoveryMoviesData: Codable {
    let page, totalResults, totalPages: Int?
    let results: [mDiscoveryMovie]?
    
    private enum CodingKeys : String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        case page
    }
}

struct mDiscoveryMovie: Codable {
    let posterPath, overview, releaseDate, originalTitle, originalLanguage: String?
    let title, backdropPath: String?
    let id, voteCount: Int?
    let popularity, voteAverage: Double
    let adult, video: Bool?
    let budget, revenue, runtime, status: Int?
    let genres: [mGenre]?
    
    private enum CodingKeys : String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case adult, video, title, id, popularity, overview
        case budget, revenue, runtime, status, genres
    }
}

struct mListVideos: Codable {
    let id: Int?
    let results: [mVideoMovie]?
}

struct mVideoMovie: Codable {
    let id, name, site, type: String?
    let size: Int?
}
