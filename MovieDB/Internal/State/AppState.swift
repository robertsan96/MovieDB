//
//  AppState.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation

class AppState: ObservableObject {
    
    @Published var customSheetActions: [CustomActionSheetAction] = []
    @Published var isShowingCustomSheet: Bool = false
    
    @Published var homeSortStrategy: HomeScreenSortStrategy = .noSort
}
