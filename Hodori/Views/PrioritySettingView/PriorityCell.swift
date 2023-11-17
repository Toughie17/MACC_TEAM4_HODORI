//
//  PriorityCell.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PriorityCell: View {
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
            
            HStack(alignment: .center, spacing: 0) {
                
                HStack(alignment: .top, spacing: 0) {
                    Image(systemName: "circle")
                        .foregroundStyle(Color.primaryBlue)
                        .font(.pretendRegular14)
                        .fontWeight(.heavy)
                        .padding(.top, 13)
                        .padding(.leading, 16)
                        .padding(.trailing, 12)
                    
                    Text(title)
                        .foregroundStyle(Color.black)
                        .font(.pretendBold16)
                        .padding(.top, 13)
                        .padding(.bottom, 12)
                }
                
                Spacer()
                
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(Color.gray5)
                    .padding(.trailing, 12)
            }
        }
        .frame(minHeight: 50)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PriorityCell(title: "테스트입니다.")
    }
}
