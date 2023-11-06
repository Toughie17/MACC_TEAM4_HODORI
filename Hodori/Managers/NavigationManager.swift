//
//  NavigationManager.swift
//  Hodori
//
//  Created by Toughie on 11/6/23.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var screenPath: [AppScreen] = []
}

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case view1
    case view2
    case view3
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .view1:
            EmptyView()
        case .view2:
            EmptyView()
        case .view3:
            EmptyView()
        }
    }
    
}
