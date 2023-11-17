//
//  HodoriApp.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import SwiftUI

@main
struct HodoriApp: App {    
    let coreDataManager = CoreDataManager.shared
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(NavigationManager())
                .environmentObject(MeetingManager())
                .environment(\.managedObjectContext, coreDataManager.viewContext)
        }
    }
}
