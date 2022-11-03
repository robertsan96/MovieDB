//
//  MainTabBarView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct MainTabBarView: View {

    @EnvironmentObject var appState: AppState
    @State public var tabViewSelection: AppScreen = .home
    @StateObject var homeScreenViewModel = HomeScreenViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $tabViewSelection) {
                
                favoritesView()
                homeView()
                searchView()
            }
            .accentColor(.white.opacity(1))
            
            homeSortActionSheet()
        }
        .onChange(of: appState.homeSortStrategy) { homeSortStrategy in
            homeScreenViewModel.setSortStrategy(sortStrategy: homeSortStrategy)
        }
    }
    
    private func favoritesView() -> some View {
        NavigationView {
            Text("Favorites")
                .navigationTitle(AppScreen.favorites.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            appState.isShowingCustomSheet.toggle()
                        } label: {
                            Image("ic_sort")
                        }
                    }
                }
        }
        .tabItem { getLabel(for: .favorites) }
        .tag(AppScreen.favorites)
    }
    
    private func homeView() -> some View {
        NavigationView {
            HomeScreenView(viewModel: homeScreenViewModel)
                .navigationTitle(AppScreen.home.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            appState.isShowingCustomSheet.toggle()
                        } label: {
                            Image("ic_sort")
                        }
                    }
                }
        }
        .tabItem { getLabel(for: .home) }
        .tag(AppScreen.home)
    }
    
    private func searchView() -> some View {
        Text("Search")
            .tabItem { getLabel(for: .search) }
            .tag(AppScreen.search)
    }
    
    private func homeSortActionSheet() -> some View {
        CustomActionSheet(backgroundTapSignal: $appState.isShowingCustomSheet, actions: [
            .regular(title: "Rating Ascending", action: {
                appState.homeSortStrategy = .ratingAscending
                appState.isShowingCustomSheet.toggle()
            }),
            .regular(title: "Rating Descending", action: {
                appState.homeSortStrategy = .ratingDescending
                appState.isShowingCustomSheet.toggle()
            }),
            .regular(title: "Release Date Ascending", action: {
                appState.homeSortStrategy = .releaseDateAscending
                appState.isShowingCustomSheet.toggle()
            }),
            .regular(title: "Release Date Descending", action: {
                appState.homeSortStrategy = .releaseDateDescending
                appState.isShowingCustomSheet.toggle()
            }),
            .cancel(action: {
                withAnimation(.easeInOut) {
                    appState.isShowingCustomSheet.toggle()
                }
            })
        ])
        .opacity(appState.isShowingCustomSheet ? 1 : 0)
    }
    
    private func getIconName(for tabItem: AppScreen) -> String {
        tabViewSelection == tabItem ? tabItem.iconPress : tabItem.icon
    }
    
    private func getLabel(for tabItem: AppScreen) -> some View {
        Label {
            Text(tabItem.title)
                .foregroundColor(.green)
        } icon: {
            Image(getIconName(for: tabItem))
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView(homeScreenViewModel: HomeScreenViewModel(movieRepository: MovieApiRepository(http: Http(), apiToken: Constants.Api.apiKey),
                                                                sortStrategy: .noSort))
            .environmentObject(AppState())
    }
}
