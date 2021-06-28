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
        case .getDiscoverMovies(_, _): return "/discover/movie"
        case .getMovieBySearch(_, _): return "/search/movie"
            
        case .getMovieDetail(let movieId): return "/movie/\(movieId)"
        case .getVideoMovie(let movieId): return "movie/\(movieId)/videos"
        case .getMovieReview(let movieId, _): return "movie/\(movieId)/reviews"
        }
    }
}
