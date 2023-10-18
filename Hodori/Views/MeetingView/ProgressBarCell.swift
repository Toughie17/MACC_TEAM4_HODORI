//
//  ProgressBar.swift
//  Hodori
//
//  Created by Eric on 10/18/23.
//

import SwiftUI

struct ProgressBarCell: View {
    @Binding var progress: Float

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 7)
                .foregroundStyle(.gray)
                .opacity(0.3)
            Rectangle()
            .frame(maxWidth: CGFloat(progress) * UIScreen.main.bounds.width, maxHeight: 7)
                .foregroundStyle(Color.progressbarRed)
                .animation(.interactiveSpring(response: 2.0, dampingFraction: 1.0, blendDuration: 0.1), value: progress)
        }
    }
}
