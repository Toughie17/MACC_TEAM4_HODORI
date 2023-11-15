//
//  AgendaCell.swift
//  Hodori
//
//  Created by 송지혁 on 11/15/23.
//

import SwiftUI

enum AgendaCellState {
    case detail
    case normal
}

struct AgendaCell: View {
    let state: AgendaCellState
    let agenda: Agenda
    let index: Int
    let meeting: Meeting
    let titleFont: Font
    
    @State private var agendaClick: [(Double, Bool)] = Array(repeating: (0, false), count: 10)
    
    var body: some View {
        switch state {
        case .normal:
            normalAgendaCell
        case .detail:
            detailAgendaCell
        }
    }
    
    private var normalAgendaCell: some View {
        Group {
            HStack(spacing: 16) {
                checkmark
                title
            }
            
            HStack(spacing: 24) {
                if index < meeting.agendas.endIndex - 1 {
                    pole
                        .frame(maxWidth: 2, maxHeight: 14)
                        .padding(.leading, 7)
                }
            }
        }
    }
    
    private var detailAgendaCell: some View {
        Group {
            HStack(spacing: 16) {
                checkmark
                title
                Spacer()
                chevron
            }
            
            HStack(spacing: 24) {
                if index < meeting.agendas.endIndex {
                    pole
                        .frame(maxWidth: 2, minHeight: 21)
                        .padding(.leading, 7)
                }
                
                if isAgendaClicked(index) {
                    detailAgendas
                }
            }
        }
    }
    
    private var checkmark: some View {
        Image(agenda.isComplete ? "agendaStatus_Complete" : "agendaStatus_Incomplete")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16)
    }
    
    private var title: some View {
        Text(agenda.title)
            .font(titleFont)
            .foregroundStyle(agenda.isComplete ? Color.gray5 : .black)
    }
    
    private var chevron: some View {
        Group {
            if let firstAgenda = agenda.detail.first, firstAgenda.isNotEmpty {
                Image(systemName: "chevron.down")
                    .foregroundStyle(agenda.isComplete ? Color.gray5 : .black)
                    .rotationEffect(Angle(degrees: agendaClick[index].0))
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)) {
                            agendaClick[index].0 += 180
                            agendaClick[index].1.toggle()
                        }
                    }
            }
        }
    }
    
    private var pole: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Color.gray9)
            
    }
    
    private var detailAgendas: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(agenda.detail, id: \.self) { detailAgenda in
                Text("\(detailAgenda)")
                    .font(.pretendMedium16)
                    .foregroundStyle(Color.gray2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
        .padding(.bottom, 29)
    }
    
    private func isAgendaClicked(_ index: Int) -> Bool {
        agendaClick[index].1
    }
    
}

#Preview {
    AgendaCell(state: .normal, agenda: Agenda(title: "", detail: [""]), index: 0, meeting: .init(agendas: [], startDate: Date()), titleFont: .pretendBold16)
}
