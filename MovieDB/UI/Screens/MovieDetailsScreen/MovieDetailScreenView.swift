//
//  MovieDetailScreenView.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import SwiftUI

struct MovieDetailScreenView: View {
    
    @StateObject var viewModel = MovieDetailScreenViewModel(movieId: 436270)
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.movie != nil {
                movieBackdrop()
                movieMetadata()
                    .padding(10)
                Rectangle()
                    .frame(height: 2)
                    .padding(10)
                    .foregroundColor(Color.appSecondary)
                Text(viewModel.movie?.overview ?? "")
                    .font(.appFont(weight: .semibold, size: 14))
                    .foregroundColor(.appSecondaryTextColor)
                    .padding(10)
                Spacer()
            } else {
                noMovieView()
            }
        }
        .background(Color.white)
    }
    
    /// As this method is invoked only after we check for nil, we can safely
    /// force unwrap the object
    private func movieMetadata() -> some View {
        HStack(spacing: 0) {
            ZStack {
                if viewModel.moviePoster != nil {
                    Image(uiImage: viewModel.moviePoster!)
                        .resizable()
                        .frame(width: 140)
                        .cornerRadius(6)
                } else {
                    Rectangle()
                        .frame(width: 140)
                        .cornerRadius(6)
                        .foregroundColor(Color.appPrimary.opacity(0.1))
                }
            }
            VStack(spacing: 0) {
                movieMetadataTitle()
                    .padding(.bottom, 12)
                movieMetadataTagline()
                    .padding(.bottom, 12)
                movieMetadataReleaseYear()
                    .padding(.bottom, 12)
                movieMetadataVoteAverage()
                    .padding(.bottom, 12)
                movieMetadataGenres()
                    .padding(.bottom, 12)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
        }
        .frame(maxHeight: 210)
    }
    
    private func movieBackdrop() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.appPrimary.opacity(0.1))
            if viewModel.movieBackdropPath != nil {
                Image(uiImage: viewModel.movieBackdropPath!)
                    .resizable()
            }
        }
        .frame(height: 200)
    }
    
    private func noMovieView() -> some View {
        if viewModel.isLoading {
            return Text("Loading..")
        } else {
            return Text("Failed loading...")
        }
    }
    
    private func movieMetadataTitle() -> some View {
        HStack {
            Text(viewModel.movie!.title ?? "")
                .font(.appFont(weight: .bold, size: 20))
                .foregroundColor(Color.appSecondaryTextColor)
                .lineLimit(1)
            Spacer()
        }
    }
    
    private func movieMetadataTagline() -> some View {
        HStack {
            Text(viewModel.movie?.tagline ?? "")
                .multilineTextAlignment(.leading)
                .font(.appFont(weight: .semibold, size: 14))
                .foregroundColor(.appTernaryTextColor)
            Spacer()
        }
    }
    
    private func movieMetadataReleaseYear() -> some View {
        HStack {
            Text("Released in \(Date.yearFromServerFormat(viewModel.movie?.releaseDate ?? ""))")
                .font(.appFont(weight: .semibold, size: 14))
                .foregroundColor(Color.appSecondaryTextColor)
            Spacer()
        }
    }
    
    private func movieMetadataVoteAverage() -> some View {
        HStack {
            Image("ic_star")
            // TODO: Do not round up decimals..
            Text(String(format: "%.2f / 10", viewModel.movie!.voteAverageOrZero))
                .font(.appFont(weight: .semibold, size: 14))
                .foregroundColor(Color.appSecondaryTextColor)
            Text("(\(String(viewModel.movie!.voteCount ?? 0)))")
                .font(.appFont(weight: .semibold, size: 14))
                .foregroundColor(Color.appTernaryTextColor)
            Spacer()
        }
    }
    
    private func movieMetadataGenres() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.movieGenres) { genre in
                    Text(genre.name)
                        .font(.appFont(weight: .semibold, size: 12))
                        .foregroundColor(Color.appSecondaryTextColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.appPrimaryTagCapsuleColor)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct MovieDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreenView()
    }
}
