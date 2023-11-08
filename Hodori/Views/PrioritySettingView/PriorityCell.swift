//
//  PriorityCell.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PriorityCell: View {
    let title: String
    let backColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(backColor))
            
            HStack {
                Image(systemName: "circle")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .padding(.leading, 17)
                
                Text(title)
                
                Spacer()
                
                Image(systemName: "line.3.horizontal")
                    .padding(.trailing, 14)
            }
        }
        .frame(height: 52)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    PriorityCell(title: "테스트 안건입니다.")
}
