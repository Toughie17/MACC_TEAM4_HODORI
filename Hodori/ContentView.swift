//
//  ContentView.swift
//  Hodori
//
//  Created by Eric on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        StartView(meeting: Meeting(agendas: [.init(title: "", detail: [""])], startDate: Date()))
    }
}

#Preview {
    ContentView()
}
