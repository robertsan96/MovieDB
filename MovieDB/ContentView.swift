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
                let url = "https://api.themoviedb.org/3/movie/now_playing"
                let params: [URLQueryItem] = [
                URLQueryItem(name: "api_key", value: "abfabb9de9dc58bb436d38f97ce882bc")
                ]
                let result = await http.get(url: url, params: params)
                switch result {
                case .success(let httpResponse):
                    let strResponse = String(data: httpResponse.data, encoding: .utf8)
                    print(strResponse)
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
