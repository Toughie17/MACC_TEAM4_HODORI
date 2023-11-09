//
//  LottieTestView.swift
//  Hodori
//
//  Created by Toughie on 11/9/23.
//

import SwiftUI

struct LottieTestView: View {
    var body: some View {
        LottieView(jsonName: "CheckLottie", loopMode: .loop)
            .frame(width: 300, height: 300)
    }
}

#Preview {
    LottieTestView()
}
