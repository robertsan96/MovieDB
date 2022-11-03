//
//  HomeScreen.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var viewModel: HomeScreenViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            HorizontalTabView(menuItems: viewModel.menuElements,
                              selected: $viewModel.activeMenuElement)
            MovieCardListView(movies: viewModel.sortedMovies,
                              isLoading: viewModel.isLoading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.appSecondary)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeScreenView(viewModel: HomeScreenViewModel(
            movieRepository: MovieApiRepository(http: Http(),
                                                apiToken: Constants.Api.apiKey),
            sortStrategy: .noSort))
    }
}
