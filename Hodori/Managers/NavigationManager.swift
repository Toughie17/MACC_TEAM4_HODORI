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
//    case prioritySetting
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
            StartView()
        case .agendaSetting:
            AgendaSettingView()
//        case .prioritySetting:
//            PrioritySettingView()
        case.meeting:
            Text("3번")
        case.allAgenda:
            Text("4번")
        case.history:
            HistoryView()
        }
    }
}
