//
//  Color+.swift
//  Hodori
//
//  Created by Toughie on 11/10/23.
//

import SwiftUI

extension Color {
    
    //MARK: Gray Scale
    static let gray1 = Color(UIColor(hexCode: "#353535"))
    static let gray2 = Color(UIColor(hexCode: "#515151"))
    static let gray3 = Color(UIColor(hexCode: "#6D6D6D"))
    static let gray4 = Color(UIColor(hexCode: "#838383"))
    static let gray5 = Color(UIColor(hexCode: "#9F9F9F"))
    static let gray6 = Color(UIColor(hexCode: "#B7B7B7"))
    static let gray7 = Color(UIColor(hexCode: "#CACACA"))
    static let gray8 = Color(UIColor(hexCode: "#D7D7D7"))
    static let gray9 = Color(UIColor(hexCode: "#E6E6E6"))
    static let gray10 = Color(UIColor(hexCode: "#F2F2F2"))
    
    //MARK: ITDA System Colors
    static let primaryBlue = Color(UIColor(hexCode: "#1C69FF"))
    static let blue1 = Color(UIColor(hexCode: "#00246B"))
    static let blue2 = Color(UIColor(hexCode: "#0040BC"))
    static let blue3 = Color(UIColor(hexCode: "#6599FF"))
    static let blue4 = Color(UIColor(hexCode: "#9CBEFF"))
    static let subRed = Color(UIColor(hexCode: "#FF7068"))
}


struct ColorPalete: View {
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 300, height: 300)
//                .foregroundStyle(Color.gray1)
//                .foregroundStyle(Color.gray2)
//                .foregroundStyle(Color.gray3)
//                .foregroundStyle(Color.gray4)
//                .foregroundStyle(Color.gray5)
//                .foregroundStyle(Color.gray6)
//                .foregroundStyle(Color.gray7)
//                .foregroundStyle(Color.gray8)
//                .foregroundStyle(Color.gray9)
//                .foregroundStyle(Color.gray10)
//                .foregroundStyle(Color.primaryBlue)
//                .foregroundStyle(Color.blue1)
//                .foregroundStyle(Color.blue2)
//                .foregroundStyle(Color.blue3)
//                .foregroundStyle(Color.blue4)
                .foregroundStyle(Color.subRed)
        }
    }
}

#Preview {
    ColorPalete()
}
