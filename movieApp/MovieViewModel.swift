//
//  MovieViewModel.swift
//  movieApp
//
//  Created by maya alasiri  on 28/07/1446 AH.
//

import Foundation


class MovieViewModel: ObservableObject {
    @Published var highRatedMovies: [Movie] = []
    @Published var dramaMovies: [Movie] = []
    @Published var comedyMovies: [Movie] = []
    @Published var searchText: String = "" 

    let apiUrl = "https://api.airtable.com/v0/appsfcB6YESLj4NCN/movies"
    let apiKey = "Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001"

    init() {
        fetchMovies()
    }

    func fetchMovies() {
        guard let url = URL(string: apiUrl) else { return }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let decodedResponse = try JSONDecoder().decode([String: [Movie]].self, from: data)
                let movies = decodedResponse["records"] ?? []
                
                // Filter high-rated movies
                self.highRatedMovies = movies.filter { $0.fields.IMDb_rating >= 9.0 }
                
                // Filter drama movies
                self.dramaMovies = movies.filter { $0.fields.genre.contains("Drama") }
                
                // Filter comedy movies
                self.comedyMovies = movies.filter { $0.fields.genre.contains("Comedy") }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}

