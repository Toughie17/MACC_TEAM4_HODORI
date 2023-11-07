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
            HStack(alignment: .center) {
                if agenda.isComplete {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                        .frame(width: 12)
                } else {
                    Image(systemName: "circle")
                        .frame(width: 12)
                }
                
                Text(agenda.title)
                    .padding(.leading, 16)
                
                Spacer()
            }
            .frame(height: 22)
            .padding(.horizontal,24)

            if target {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue.opacity(0.2))
                    .frame(height: 35)
            }
        }
        .padding(.vertical, 6)
    }
}

