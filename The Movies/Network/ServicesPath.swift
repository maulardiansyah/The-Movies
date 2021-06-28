//
//  ServicesPath.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

extension Services
{
    var path: String {
        switch self {
        case .getListGenres: return "/genre/movie/list"
        case .getDiscoverMovies(let genreId, let page): return "/discover/movie?with_genres=\(genreId)&page=\(page)"
        case .getMovieBySearch(let query, let page): return "/search/movie?query=\(query)&page=\(page)"
            
        case .getMovieDetail(let movieId): return "/movie/\(movieId)"
        case .getVideoMovie(let movieId): return "movie/\(movieId)/videos"
        case .getMovieReview(let movieId, let page): return "movie/\(movieId)/reviews?page=\(page)"
        }
    }
}
