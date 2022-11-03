//
//  FavoriteScreenView.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct FavoriteScreenView: View {
    
    @ObservedObject var viewModel = FavoriteScreenViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.filteredMovies.count > 0 {
                MovieCardListView(movies: viewModel.filteredMovies,
                                  isLoading: false)
                .id(appState.refreshHack)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Spacer()
                    Text("No favorites, yet.")
                        .font(.appFont(weight: .semibold, size: 22))
                        .foregroundColor(.appSecondaryTextColor)
                    Text("Disclaimer: if you don't see your favorite movie here, it's because i am checking for the popular movies list only due to the lack of time (instead of fetching a list of ids stored on the device). \n\n Anyway, your favorites are safely stored on the device even though they don't show up here. 😅")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.appSecondaryTextColor)
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.appSecondary)
    }
}

struct FavoriteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreenView()
            .environmentObject(AppState())
    }
}
