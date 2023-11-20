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
    let needUpperLine: Bool
    let needLowerLine: Bool
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                
                if needUpperLine {
                    HStack(alignment: .center, spacing: 0) {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 2)
                            .frame(height: target ? 1 : 8.5)
                        
                            .foregroundStyle(Color.gray9)
                        Spacer()
                    }
                    .padding(.leading, target ? 27 : 7)
                    .padding(.bottom, target ? 4 : 0)
                }
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: agenda.isComplete ? "checkmark.circle.fill" : "circle.fill")
                        .foregroundStyle(agenda.isComplete ? Color.primaryBlue : Color.gray8)
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 12)
                    Text(agenda.title)
                        .foregroundStyle(agenda.isComplete ? Color.gray5 : Color.gray1)
                        .font(.pretendMedium16)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.vertical, target ? 8 : 0)
                .padding(.leading, target ? 20 : 0)
                .padding(.trailing, target ? 20 : 0)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(target ? Color.blue4.opacity(0.3) : Color.clear)
                        .frame(height: 41)
                )
                
                if needLowerLine {
                    HStack(alignment: .center, spacing: 0) {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 2)
                            .frame(height: target ? 1 : 8.5)
                            .foregroundStyle(Color.gray9)
                        
                        Spacer()
                    }
                    .padding(.leading, target ? 27 : 7)
                    .padding(.top, target ? 4 : 0)
                }
            }
        }
        .padding(.horizontal, target ? 0 : 20)
        .padding(.horizontal, 24)
        .background(Color.white)
    }
}

extension AllAgendaCell {
    private var checkTextLine: some View {
        HStack(alignment: .center, spacing: 0) {
            
            Image(systemName: agenda.isComplete ? "checkmark.circle.fill" : "circle")
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
    }
}

#Preview {
    AllAgendaCell(agenda: Agenda(title: "아아아아아아아아아아아아아아아아아아아", detail: [], isComplete: false),target: false, needUpperLine: true, needLowerLine: true)
}
