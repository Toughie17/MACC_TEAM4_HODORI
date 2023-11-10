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
    case start
    case agendaSetting
    case prioritySetting
    case meeting
    case allAgenda
    case history
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .start:
            EmptyView()
        case .agendaSetting:
            AgendaSettingView()
        case .prioritySetting:
            EmptyView()
        case.meeting:
            EmptyView()
        case.allAgenda:
            EmptyView()
        case.history:
            EmptyView()
        }
    }
}
