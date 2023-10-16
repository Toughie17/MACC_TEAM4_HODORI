//
//  HodoriApp.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import FirebaseCore
import SwiftUI

@main
struct HodoriApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MeetingManager(timer: TimerManager()))
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
