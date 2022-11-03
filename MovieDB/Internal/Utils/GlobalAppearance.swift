//
//  GlobalAppearance.swift
//  MovieDB
//
//  Created by Robert Sandru on 02.11.2022.
//

import UIKit
import SwiftUI

func setupGlobalAppearance() {
    UITabBar.appearance().backgroundColor = UIColor(Color.appPrimary)
    UITabBar.appearance().unselectedItemTintColor = .white.withAlphaComponent(Constants.UI.tabBarInactiveAlpha)
    UITabBarItem.appearance().setTitleTextAttributes([
        .font: UIFont.appFont(weight: .semibold, size: Constants.UI.tabBarFontSize)
    ], for: .normal)
    
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navBarAppearance.backgroundColor = UIColor(Color.appPrimary)
    navBarAppearance.titleTextAttributes = [.font : UIFont.appFont(.openSans, weight: .bold, size: 16),
                                            .foregroundColor : UIColor(Color.appPrimaryTextColor)]
    navBarAppearance.shadowColor = .clear
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
}
