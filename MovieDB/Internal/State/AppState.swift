//
//  AppState.swift
//  MovieDB
//
//  Created by Robert Sandru on 03.11.2022.
//

import Foundation

class AppState: ObservableObject {
    
    @Published var customSheetActions: [CustomActionSheetAction] = []
    @Published var isShowingCustomSheet = false
    
    @Published var homeSortStrategy: HomeScreenSortStrategy = .noSort
    @Published var searchKeyword = ""
    
    // Absolute hack due to lack of time
    // TODO: Notifications, Combine etc
    @Published var refreshHack: UUID = UUID()
}
