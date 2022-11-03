//
//  FavoriteScreenView.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct FavoriteScreenView: View {
    
    @StateObject var viewModel = FavoriteScreenViewModel()
    @EnvironmentObject var appState: AppState
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.filteredMovies.count > 0 {
                MovieCardListView(movies: viewModel.filteredMovies,
                                  isLoading: false)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Spacer()
                    Text("No favorites, yet.")
                        .font(.appFont(weight: .semibold, size: 22))
                        .foregroundColor(.appSecondaryTextColor)
                    Image("ic_add_to_favorites_red")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaleEffect(animationAmount)
                        .animation(
                            .linear(duration: 0.1)
                            .delay(0.2)
                            .repeatForever(autoreverses: true),
                            value: animationAmount)
                        .onAppear {
                            animationAmount = 1.2
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.clear.disabled(appState.refreshHack))
        .background(Color.appSecondary)
    }
}

struct FavoriteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreenView()
            .environmentObject(AppState())
    }
}
