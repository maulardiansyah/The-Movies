//
//  mUserReview.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

struct mListMovieReviews: Codable {
    let id, page: Int?
    let results: [mUserReview]?
    let totalResults, totalPages: Int?
    
    private enum CodingKeys : String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results, id, page
    }
}

struct mUserReview: Codable {
    let author, content, id: String?
    let createdAt, updatedAt: String?
    let authorDetails: mUserDetails?
    
    private enum CodingKeys : String, CodingKey {
        case author, content, id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case authorDetails = "author_details"
    }
}

struct mUserDetails: Codable {
    let name, username, avatarPath: String?
    let rating: Int?
    
    private enum CodingKeys : String, CodingKey {
        case avatarPath = "avatar_path"
        case name, username, rating
    }
}
