//
//  MovieCardListView.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct MovieCardListView: View {
    
    var movies: [Movie]
    var isLoading: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if isLoading {
                movieListPlaceholder()
                    .padding(5)
            } else {
                movieList()
                    .padding(5)
            }
        }
    }
    
    private func loadingView() -> some View {
        VStack {
            // TODO: Find out why the spinner is not loading on simulator. It does load on previews....?
            // ProgressView()
            //     .progressViewStyle(.circular)
            //     .foregroundColor(.appPrimary)
            Text("Loading...")
                .font(.appFont(weight: .semibold, size: 16))
                .foregroundColor(.appPrimary)
        }
    }
    
    private func movieList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(movies) { movie in
                    MovieCardListItem(viewModel: MovieCardListItemViewModel(movie: movie))
                }
            }
        }
    }
    
    private func movieListPlaceholder() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(0..<10) { index in
                    MovieCardListItem(viewModel: MovieCardListItemViewModel(movie: .blank))
                }
            }
        }
    }
}

struct MovieCardListItem: View {
    
    @StateObject var viewModel: MovieCardListItemViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(height: 270)
                    .cornerRadius(6)
                    .padding(2)
                Image(uiImage: viewModel.posterImage ?? .init())
                    .resizable()
                    .cornerRadius(6)
                    .padding(2)
                
            }
            .frame(height: 270)
            HStack {
                Spacer()
                Text(viewModel.releaseYear)
                    .font(.appFont(weight: .semibold, size: 14))
                    .foregroundColor(.appSecondaryTextColor)
                Spacer()
                Image("ic_star")
                    .resizable()
                    .frame(width: 14, height: 14)
                Text(viewModel.voteAverage)
                    .font(.appFont(weight: .semibold, size: 14))
                    .foregroundColor(.appSecondaryTextColor)
                Spacer()
                Button {
                    
                } label: {
                    Image("ic_add_to_favorites_red")
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 40)
        }
        .background(Color.white)
        .cornerRadius(6)
    }
}

struct MovieCardListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardListView(movies: [
            Movie(id: 123,
                  title: "Terrifier",
                  overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
                  genreIds: [27, 53],
                  backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
                  posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
                  voteAverage: 7.2,
                  releaseDate: "2022-10-06"),
            Movie(id: 123,
                  title: "Terrifier",
                  overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
                  genreIds: [27, 53],
                  backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
                  posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
                  voteAverage: 7.2,
                  releaseDate: "2022-10-06"),
            Movie(id: 123,
                  title: "Terrifier",
                  overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
                  genreIds: [27, 53],
                  backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
                  posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
                  voteAverage: 7.2,
                  releaseDate: "2022-10-06"),
            Movie(id: 123,
                  title: "Terrifier",
                  overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Art's evil intent.",
                  genreIds: [27, 53],
                  backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
                  posterPath: "/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg",
                  voteAverage: 7.2,
                  releaseDate: "2022-10-06")
        ], isLoading: false)
    }
}
