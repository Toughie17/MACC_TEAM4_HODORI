//
//  PageControl.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct CustomPageControl: View {
    
    @Binding var selectedTab: Int
    let totalTabs: Int
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 0) {
                ForEach(0..<totalTabs, id: \.self) { index in
                    Circle()
                        .fill(index == selectedTab ? Color.black : Color.black.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .padding(8)
                        .onTapGesture {
                            selectedTab = index
                        }
                }
            }
        }
        .frame(height: 44)
    }
}

//#Preview {
//    CustomPageControl(selectedTab: .constant(3), totalTabs: 5)
//}
