//
//  MeetingTabViewCell.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct MeetingTabViewCell: View {
    let agenda: Agenda
    let index: Int
    let backColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593991637, alpha: 1)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(backColor))
            
            VStack(alignment: .leading, spacing: 0) {
                agendaOrderText
                    .padding(.bottom, 12)
                currentAgendaTitle
                    .padding(.bottom, 20)
                agendaDetails
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
        }
    }
}

extension MeetingTabViewCell {
    
    private var agendaOrderText: some View {
        HStack {
            if agenda.isComplete {
                Image(systemName: "checkmark")
            } else {
                Image(systemName: "circle")
            }
            Text(agendaTitle(forIndex: index))
                .padding(.leading, 12)
            Spacer()
        }
    }
    
    private var currentAgendaTitle: some View {
        Text(agenda.title)
    }
    
    private var agendaDetails: some View {
        ForEach(agenda.detail, id: \.self) { detail in
            HStack(spacing: 0) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 3, height: 3)
                Text(detail)
                    .padding(.leading, 8)
            }
            .padding(.bottom, 4)
        }
    }
    
    private func agendaTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫번째 안건"
        case 1:
            return "두번째 안건"
        case 2:
            return "세번째 안건"
        case 3:
            return "네번째 안건"
        case 4:
            return "다섯번째 안건"
        case 5:
            return "여섯번째 안건"
        case 6:
            return "일곱번째 안건"
        case 7:
            return "여덟번째 안건"
        case 8:
            return "아홉번째 안건"
        case 9:
            return "열번째 안건"
        default:
            return "알 수 없는 안건"
        }
    }
}

#Preview {
    MeetingTabViewCell(agenda: Agenda(title: "텝뷰 테스트", detail: ["1", "2", "3", "4", "5"], isComplete: false), index: 0)
}
