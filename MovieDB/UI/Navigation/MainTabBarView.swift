//
//  MainTabBarView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct MainTabBarView: View {
    
    @State public var selection: AppScreen = .home
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationView {
                HomeScreenView()
                    .navigationTitle(AppScreen.favorites.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem { getLabel(for: .favorites) }
            .tag(AppScreen.favorites)
            
            NavigationView {
                HomeScreenView()
                    .navigationTitle(AppScreen.home.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem { getLabel(for: .home) }
            .tag(AppScreen.home)
            
            Text("Search")
                .tabItem { getLabel(for: .search) }
                .tag(AppScreen.search)
        }
        .accentColor(.white.opacity(1))
    }
    
    private func getIconName(for tabItem: AppScreen) -> String {
        selection == tabItem ? tabItem.iconPress : tabItem.icon
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
        MainTabBarView()
    }
}
