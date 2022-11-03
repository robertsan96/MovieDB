//
//  ContentView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainTabBarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
            .preferredColorScheme(.dark)
            .onAppear {
                setupGlobalAppearance()
            }
    }
}
