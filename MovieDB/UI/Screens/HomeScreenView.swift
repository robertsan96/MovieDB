//
//  HomeScreen.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct HomeScreenView: View {
    
    @StateObject var viewModel = HomeScreenViewModel(movieRepository: MovieApiRepository(http: Http(), apiToken: "abfabb9de9dc58bb436d38f97ce882bc"))
    @State var showingSortMenu = false
    
    var body: some View {
        VStack(spacing: 0) {
            HorizontalTabView(menuItems: viewModel.menuElements,
                              selected: $viewModel.activeMenuElement)
            MovieCardListView(movies: viewModel.paginatedResponse.results,
                              isLoading: viewModel.isLoading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.appSecondary)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingSortMenu.toggle()
                } label: {
                    Image("ic_sort")
                }
            }
        }
        .actionSheet(isPresented: $showingSortMenu) {
            sortActionSheet
        }
    }
    
    var sortActionSheet: ActionSheet {
        ActionSheet(title: Text("Sort"), buttons: [
            .cancel(Text("Cancel")),
            .default(Text("Rating ascending"), action: {
                
            }),
            .default(Text("Rating descending"), action: {
                
            }),
            .default(Text("Release date ascending"), action: {
                
            }),
            .default(Text("Release date descending"), action: {
                
            }),
        ])
    }
}

struct HomeScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeScreenView()
    }
}
