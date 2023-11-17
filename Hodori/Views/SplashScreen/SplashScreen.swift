//
//  SplashScreen.swift
//  Hodori
//
//  Created by 송지혁 on 11/17/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashScreen: View {
    @State private var isAnimating = true
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigationManager.screenPath) {
            ZStack {
                Color.gray10
                    .ignoresSafeArea()
                
                AnimatedImage(name: "ITDA_Splash.gif", isAnimating: $isAnimating)
                    .customLoopCount(1)
                    
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.22) {
                            navigationManager.screenPath.append(.start)
                        }
                    }
                    .frame(width: 400, height: 400)
                    
            }
            .navigationDestination(for: AppScreen.self) { appScreen in
                appScreen.destination
            }
        }
    }
}

#Preview {
    SplashScreen()
}
