//
//  AllAgendaCell.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct AllAgendaCell: View {
    let agenda: Agenda
    let target: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                
                Image(systemName: agenda.isComplete ? "checkmark" : "circle")
                    .foregroundStyle(agenda.isComplete ? .blue : Color.gray5)
                    .frame(width: 12, height: 12)
                
                Text(agenda.title)
                    .foregroundStyle(agenda.isComplete ? Color.gray5 : Color.gray1)
                    .font(.pretendMedium16)
                    .padding(.leading, 16)
                
                Spacer()
            }
            .frame(height: 22)
            .padding(.vertical, 5)
            .padding(.horizontal,24)

                RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(target ? .blue.opacity(0.2) : .white.opacity(0.1))
                    .frame(height: 31)

        }
    }
}

#Preview {
    AllAgendaCell(agenda: Agenda(title: "hi", detail: [], isComplete: true), target: true)
}
