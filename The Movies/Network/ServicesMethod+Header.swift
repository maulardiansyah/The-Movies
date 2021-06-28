//
//  ServicesMethod+Header.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import Alamofire

extension Services
{
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        default:
            return getBearer()
        }
    }
    
    func getBearer() -> HTTPHeaders {
        let bearer = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMmVlYzFlYjZlYjM0ODI1Y2FlYzI5NjA0YmJlOGI5MSIsInN1YiI6IjVkODNhOGM0OGQyMmZjMDI0MmE1ZDlmYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0zHVL4hu8kUXxbA4SMwlzP-6ZMojABEL-jtNRrwyJPE"
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(bearer)"
        ]
        return header
    }
}

