//
//  MovieCardListItemView.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct MovieCardListItem: View {
    
    @StateObject var viewModel: MovieCardListItemViewModel
    
    // Pure hack for quick view reload after stored to favs
    @State var refresh: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(height: 270)
                    .cornerRadius(6)
                    .padding(2)
                Image(uiImage: viewModel.posterImage ?? .init())
                    .resizable()
                    .cornerRadius(6)
                    .padding(2)
                
            }
            .frame(height: 270)
            HStack {
                Spacer()
                Text(viewModel.releaseYear)
                    .font(.appFont(weight: .semibold, size: 14))
                    .foregroundColor(.appSecondaryTextColor)
                Spacer()
                Image("ic_star")
                    .resizable()
                    .frame(width: 14, height: 14)
                Text(viewModel.voteAverage)
                    .font(.appFont(weight: .semibold, size: 14))
                    .foregroundColor(.appSecondaryTextColor)
                Spacer()
                Button {
                    if isMovieFavorite() {
                        UserDefaultsHandler.shared.removeFavoriteMovie(movieId: viewModel.movie.id)
                    } else {
                        UserDefaultsHandler.shared.setFavoriteMovie(movieId: viewModel.movie.id)
                    }
                    refresh.toggle()
                } label: {
                    
                    Image(isMovieFavorite() ? "ic_add_to_favorites_red" : "ic_add_to_favorites_black")
                }
                Spacer()
                
            }
            .background(Color.clear.disabled(refresh))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 40)
        }
        .background(Color.white)
        .cornerRadius(6)
    }
    
    private func isMovieFavorite() -> Bool {
        UserDefaultsHandler.shared.getFavoriteMovieIds().first { $0 == viewModel.movie.id } != nil
    }
}
