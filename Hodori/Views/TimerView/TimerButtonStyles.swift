//
//  TimerButtonStyles.swift
//  Hodori
//
//  Created by Yujin Son on 2023/11/14.
//

import Foundation
import SwiftUI

struct CircleStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(.gray)
            .overlay(
                Circle()
                    .fill(.gray)
                    .foregroundColor(.white)
            )
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .overlay(
                configuration.label
                    .foregroundColor(.white)
            )
            .frame(width: 40, height: 40)
    }
}
