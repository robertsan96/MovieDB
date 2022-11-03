//
//  SearchScreenView.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct SearchScreenView: View {
    
    @ObservedObject var viewModel = SearchScreenViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            MovieCardListView(movies: viewModel.movies,
                              isLoading: false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.appSecondary)
    }
}

struct SearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenView()
            .preferredColorScheme(.dark)
    }
}
