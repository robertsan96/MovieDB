//
//  ContentView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            Task {
                let http = Http()
                let repo = MovieApiRepository(http: http, apiToken: "abfabb9de9dc58bb436d38f97ce882bc")
                
                let data = await repo.getPaginatedNowPlayingMovies()
                switch data {
                case .success(let success):
                    print(success.results)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
