//
//  MovieCardListView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct MovieCardListView: View {
    
    var movies: [Movie]
    var isLoading: Bool
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if isLoading {
                movieListPlaceholder().padding(5)
            } else {
                movieList().padding(5)
            }
        }
    }
    
    private func loadingView() -> some View {
        VStack {
            Text("Loading...")
                .font(.appFont(weight: .semibold, size: 16))
                .foregroundColor(.appPrimary)
        }
    }
    
    private func movieList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(movies) { movie in
                    NavigationLink {
                        MovieDetailScreenView(viewModel: MovieDetailScreenViewModel(movieId: movie.id))
                            .navigationTitle(movie.title ?? "")
                    } label: {
                        MovieCardListItem(viewModel: MovieCardListItemViewModel(movie: movie))
                    }
                }
            }
        }
    }
    
    private func movieListPlaceholder() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(0..<10) { index in
                    MovieCardListItem(viewModel: MovieCardListItemViewModel(movie: .blank))
                }
            }
        }
    }
}

struct MovieCardListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardListView(movies: Movie.previews, isLoading: false)
    }
}
