//
//  Movie.swift
//  movieApp
//
//  Created by maya alasiri  on 28/07/1446 AH.
//

import SwiftUI
struct Movie: Identifiable, Codable {
    let id: String
    let fields: Fields
    
    struct Fields: Codable {
        let name: String
        let rating: String
        let genre: [String]
        let poster: String
        let language: [String]
        let IMDb_rating: Double
        let runtime: String
        let story: String
    }
}
