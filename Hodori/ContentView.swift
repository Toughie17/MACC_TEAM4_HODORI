//
//  ContentView.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
<<<<<<< HEAD
//        TimerComponent()
        TimerTestDummy()
=======
        NewMeetingSetupView()
>>>>>>> sprint1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MeetingManager(timer: TimerManager()))
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
