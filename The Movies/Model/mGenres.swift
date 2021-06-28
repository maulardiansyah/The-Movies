//
//  mGenres.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

struct mGenresData: Codable {
    let genres: [mGenre]?
}

struct mGenre: Codable {
    let id: Int?
    let name: String?
}
