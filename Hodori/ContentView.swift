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
        NavigationStack(path: $navigationManager.screenPath) {
            Group {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                    
                    Button("뷰 이동") {
                        navigationManager.screenPath.append(.agendaSetting)
                    }
                }
            }
            .navigationDestination(for: AppScreen.self) { appScreen in
                appScreen.destination
            }
        }
    }
}

#Preview {
    ContentView()
}
