//
//  ContentView.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimerComponent()
    }
}

#Preview {
    ContentView()
        .environmentObject(MeetingModel(timer: TimerManager()))
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeLeft)
        
}
