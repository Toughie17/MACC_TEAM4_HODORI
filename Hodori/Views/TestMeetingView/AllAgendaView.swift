//
//  AllAgendaView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct AllAgendaView: View {
    
    @Binding var showSheet: Bool
    
    @State var agendas: [Agenda] = [
        
        Agenda(title: "안건1", detail: [], isComplete: false),
        Agenda(title: "안건2", detail: [], isComplete: true),
        Agenda(title: "안건3", detail: [], isComplete: false),
        Agenda(title: "안건4", detail: [], isComplete: true),
        Agenda(title: "안건5", detail: [], isComplete: false)
    ]
    
    @State var currentTab: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                Text("회의 전체 안건")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .padding(.bottom, 64)
                
                PieChartView(agendas: agendas)
                    .padding(.bottom, 24)
                
                Text("지금은 \(currentTab + 1)번째 안건 회의 중이에요")
                    .padding(.bottom, 60)
                
                ForEach(agendas.indices, id: \.self) { index in
                    if index == currentTab {
                        AllAgendaCell(agenda: agendas[index], target: true)
                    } else {
                        AllAgendaCell(agenda: agendas[index], target: false)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 19)
                    .padding(.top, 32)

                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    AllAgendaView()
//}

struct AllAgendaCell: View {
    let agenda: Agenda
    var target: Bool
    
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
            .padding(.horizontal,24)

            
            if target {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue.opacity(0.2))
                    .frame(height: 31)
            }
        }
        .padding(.bottom, 12)
    }
}

//#Preview {
//    AllAgendaCell(agenda: Agenda(title: "테스트 안건입니다. 테스형", detail: [], isComplete: true), target: true)
//}
