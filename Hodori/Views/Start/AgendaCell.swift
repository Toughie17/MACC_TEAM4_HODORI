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
        VStack(spacing: 0) {
            switch state {
            case .normal:
                normalAgendaCell
            case .detail:
                detailAgendaCell
            }
        }
        .padding(.leading, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var normalAgendaCell: some View {
        Group {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    checkmark
                        .padding(.trailing, 16)
                    title
                }
                
                pole
                    .frame(width: 2, height: 14)
                    .padding(.leading, 7)
            }
        }
    }
    
    private var detailAgendaCell: some View {
        Group {
            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 0) {
                    checkmark
                        .padding(.trailing, 16)
                    title
                    Spacer()
                    chevron
                }
                
                HStack(spacing: 24) {
                    pole
                        .frame(maxWidth: 2, minHeight: 21)
                        .padding(.leading, 7)
                    
                    if isAgendaClicked(index) {
                        VStack(alignment: .leading, spacing: 7) {
                            detailAgendas
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 14)
                        .padding(.bottom, 32)
                    }
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
                    .font(.system(size: 14, weight: .medium))
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
            .foregroundStyle(index < meeting.agendas.endIndex - 1 ? Color.gray9 : Color.clear)
    }
    
    private var detailAgendas: some View {
        ForEach(agenda.detail, id: \.self) { detailAgenda in
            Text("\(detailAgenda)")
                .font(.pretendMedium16)
                .foregroundStyle(agenda.isComplete ? Color.gray6 : Color.gray2)
        }
    }
    
    private func isAgendaClicked(_ index: Int) -> Bool {
        agendaClick[index].1
    }
}

#Preview {
    AgendaCell(state: .normal, agenda: Agenda(title: "", detail: [""]), index: 0, meeting: .init(agendas: [], startDate: Date()), titleFont: .pretendBold16)
}
