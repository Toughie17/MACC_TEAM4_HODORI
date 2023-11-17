//
//  View+.swift
//  Hodori
//
//  Created by 송지혁 on 11/15/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func center(_ alignment: Axis.Set) -> some View {
        switch alignment {
        case .horizontal:
            HStack {
                Spacer()
                self
                Spacer()
            }
        case .vertical:
            VStack {
                Spacer()
                self
                Spacer()
            }
        default: self
            
        }
    }
}

extension View {
    func cardBackground(opacity: CGFloat, radius: CGFloat, y: CGFloat) -> some View {
        self
            .modifier(CardBackgroundModifier(opacity: opacity, radius: radius, y: y))
    }
}
