//
//  ContentView.swift
//  movieApp
//
//  Created by maya alasiri  on 19/07/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Profile Icon & Movies Center Title
                        HStack {
                            Text("Movies Center")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(height: 50)

                            Spacer()

                            NavigationLink(destination: Account().accentColor(.yellow)) {
                                Image("Profile Icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Search Bar
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 40)
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding(.leading, 8)
                                
                                TextField(
                                    "",
                                    text: $viewModel.searchText,
                                    prompt: Text("Search for Movie name, actors...")
                                        .foregroundColor(Color(red: 235 / 255, green: 235 / 255, blue: 245 / 255))
                                )
                                .foregroundColor(.white)
                                .padding(.leading, 5)
                            }
                        }
                        .padding(.horizontal)
                        
                        // High Rated Section (No "Show me more")
                        SectionHeader(title: "High Rated", actionText: nil)
                        
                        // High Rated Movies with Page Control
                        TabView {
                            ForEach(viewModel.highRatedMovies) { movie in
                                MoviePosterView(
                                    posterURL: movie.fields.poster,
                                    movieName: movie.fields.name, // Pass movie name
                                    width: 366,
                                    height: 434,
                                    cornerRadius: 8
                                )
                            }
                        }
                        .frame(height: 500)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .padding(.horizontal)
                        .padding(.bottom, 15)

                        // Drama Section
                        SectionHeader(title: "Drama", actionText: "Show me more")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(viewModel.dramaMovies) { movie in
                                    MoviePosterView(
                                        posterURL: movie.fields.poster,
                                        movieName: movie.fields.name, // Pass movie name
                                        width: 150,
                                        height: 200,
                                        cornerRadius: 10
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Comedy Section
                        SectionHeader(title: "Comedy", actionText: "Show me more")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(viewModel.comedyMovies) { movie in
                                    MoviePosterView(
                                        posterURL: movie.fields.poster,
                                        movieName: movie.fields.name, // Pass movie name
                                        width: 150,
                                        height: 200,
                                        cornerRadius: 10
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let title: String
    let actionText: String?

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            if let actionText = actionText {
                Text(actionText)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Movie Poster View with Gradient and Text Overlay
struct MoviePosterView: View {
    let posterURL: String
    let movieName: String
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Poster Image
            AsyncImage(url: URL(string: posterURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } placeholder: {
                ProgressView()
                    .frame(width: width, height: height)
            }
            
            // Gradient Overlay for the Bottom Half of the Image
            LinearGradient(
                colors: [Color.black.opacity(0.6), .clear],
                startPoint: .bottom,
                endPoint: .center
            )
            .frame(height: height / 2) // Cover only the bottom half
            .frame(width: width, height: height, alignment: .bottom)
            .cornerRadius(cornerRadius)

            // Movie Name Text (Without Shadow)
            Text(movieName)
                           .font(.system(size: 24, weight: .bold)) // Match "Movies Center" text size
                           .foregroundColor(.white)
                           .padding(.horizontal, 8)
                           .padding(.vertical, 4)
                           .background(Color.black.opacity(0.3)) // Slight background for readability
                           .cornerRadius(5)
                           .padding([.leading, .bottom], 8) // Align text to bottom-left
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
