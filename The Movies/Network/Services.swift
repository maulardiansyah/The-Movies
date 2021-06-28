//
//  Services.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

enum Services
{
    case getListGenres
    case getDiscoverMovies(_ genres: String, _ page: Int)
    case getMovieBySearch (_ keyword: String, _ page: Int)
    
    case getMovieDetail(_ movieId: Int)
    case getVideoMovie(_ movieId: Int)
    case getMovieReview(_ movieId: Int, _ page: Int)
}
