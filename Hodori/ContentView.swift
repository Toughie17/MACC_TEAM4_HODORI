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
                    Text("스타트뷰")
                    
                    Button(action: {navigationManager.screenPath.append(.prioritySetting)}, label: {
                        Text("Button")
                    })
                    
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
