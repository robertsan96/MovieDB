//
//  Container.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import SwiftUI

struct Container: EnvironmentKey {
    
    let state: Store<AppState>
    
    init(state: Store<AppState>) {
        self.state = state
    }
    
    init(state: AppState) {
        self.init(state: Store<AppState>(state))
    }
    
    static var defaultValue = Self(state: AppState())
}

// MARK: Adding Container to EnvironmentValues

extension EnvironmentValues {
    
    var container: Container {
        get { self[Container.self] }
        set { self[Container.self] = newValue }
    }
}

#if DEBUG
extension Container {
    
    static var preview: Self {
        .init(state: AppState.preview)
    }
}
#endif

extension View {
    
    func container(_ container: Container) -> some View {
        return self.environment(\.container, container)
    }
}
