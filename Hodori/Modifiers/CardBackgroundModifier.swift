//
//  CardBackgroundModifier.swift
//  Hodori
//
//  Created by 송지혁 on 11/15/23.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    let opacity: CGFloat
    let radius: CGFloat
    let y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 4)
            }
    }
}
