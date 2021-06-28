//
//  ServicesParameter.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

extension Services
{
    var parameter: [String: Any]? {
        switch self {
        case .getDiscoverMovies(let genres, let page):
            return ["with_genres": genres, "page": page]
        case .getMovieBySearch(let keyword, let page):
            return ["query": keyword, "page": page]
            
        case .getMovieReview(_, let page):
            return ["page": page]
            
        default:
            return nil
        }
    }
}
