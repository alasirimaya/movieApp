📽️ Movie App
A SwiftUI-based iOS application that allows users to explore, search, and manage their favorite movies. This app integrates with an API to fetch movie data and supports CRUD operations for managing user movie lists.



___

🚀 Features

✅ User Authentication – Sign in securely using email & password.

✅ Movie Exploration – Browse a vast collection of movies.

✅ Search Functionality – Find movies instantly by title.

✅ CRUD Operations – Users can create, read, update, and delete movies from their watchlist.

✅ API Integration – Fetch movie details using an external API.

___

🛠️ Tech Stack

Language: Swift
Frameworks: SwiftUI, Combine
Architecture: MVVM
Networking: URLSession
State Management: ObservableObject
Storage: Core Data / User Defaults 
🔗 API Integration

The app fetches movie data from an external Movies API.

Example API Call (GET request)
let url = URL(string: "https://api.example.com/movies")!

URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data {
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            DispatchQueue.main.async {
                self.movies = movies
            }
        } catch {
            print("Error decoding movies: \(error)")
        }
    }
}.resume()

___

🔄 CRUD Operations

1️⃣ Create (Add a Movie to Watchlist)
func addMovieToWatchlist(movie: Movie) {
    watchlist.append(movie)
}
2️⃣ Read (Fetch Movies)
func fetchMovies() {
    // Calls API and updates movie list
}
3️⃣ Update (Modify a Movie's Details)
func updateMovie(movie: Movie) {
    if let index = watchlist.firstIndex(where: { $0.id == movie.id }) {
        watchlist[index] = movie
    }
}
4️⃣ Delete (Remove from Watchlist)
func deleteMovie(movie: Movie) {
    watchlist.removeAll { $0.id == movie.id }
}
___

🧪 Unit Testing 

The app includes unit tests to verify critical functionalities.

Example: Unit Test for API Response
func testFetchMovies() {
    let expectation = XCTestExpectation(description: "Fetch Movies")
    
    APIService.fetchMovies { movies in
        XCTAssertNotNil(movies, "Movies should not be nil")
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
}
___

📌 Installation & Setup

1️⃣ Clone the repository:

git clone https://github.com/your-username/movie-app.git


2️⃣ Open movieApp.xcodeproj in Xcode.

3️⃣ Run the app on a simulator or device.

📜 License

This project is open-source under the MIT License.
