//
//  HodoriApp.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import SwiftUI

@main
struct HodoriApp: App {
    @StateObject var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationManager)
        }
    }
}
