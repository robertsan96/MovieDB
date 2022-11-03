//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

@main
struct MovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .onAppear {
                    setupGlobalAppearance()
                }
        }
    }
}
