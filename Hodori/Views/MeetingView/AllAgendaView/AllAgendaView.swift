//
//  AllAgendaView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct AllAgendaView: View {
    
    @Binding var showSheet: Bool
    @Binding var agendas: [Agenda]
    @Binding var currentTab: Int
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Text("전체 안건")
                    .font(.pretendBold20)
                    .foregroundStyle(Color.gray2)
                    .padding(.top, 21)
                    .padding(.bottom, 44)
                
                PieChartView(agendas: agendas)
                    .frame(width: 30, height: 30)
                    .padding(.bottom, 20)
                
                Text("지금은 \(currentTab + 1)번째 안건\n회의 중이에요")
                    .multilineTextAlignment(.center)
                    .font(.pretendBold24)
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 50)
                
                if agendas.isNotEmpty {
                    let firstIndex = agendas.startIndex
                    let lastIndex = agendas.index(before: agendas.endIndex)
                    
                    ForEach(agendas.indices, id: \.self) { index in
                        if index == firstIndex {
                            if index == currentTab {
                                AllAgendaCell(agenda: agendas[index], target: true, needUpperLine: false, needLowerLine: true)
                            } else {
                                AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: false, needLowerLine: true)
                            }
                        }
                        
                        else if index == lastIndex {
                            if index == currentTab {
                                AllAgendaCell(agenda: agendas[index], target: true, needUpperLine: true, needLowerLine: false)
                            } else {
                                AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: true, needLowerLine: false)
                            }
                        } else {
                            if index == currentTab {
                                AllAgendaCell(agenda: agendas[index], target: true, needUpperLine: true, needLowerLine: true)
                            } else {
                                AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: true, needLowerLine: true)
                            }
                        }
                    }
                }
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSheet = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundStyle(Color.gray3)
                    }
                    .padding(.trailing, 19)
                    .padding(.top, 21)
                }
                Spacer()
            }
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    AllAgendaView(showSheet: .constant(true), agendas: .constant([Agenda(title: "춘식이의파자마춘식이의파자마 춘식이의파자마", detail: [],isComplete: false),Agenda(title: "춘식이의 파자마", detail: [],isComplete: false),Agenda(title: "춘식이의 파자마", detail: [],isComplete: true),Agenda(title: "춘식이의파자마", detail: [],isComplete: false)]), currentTab: .constant(1))
}
