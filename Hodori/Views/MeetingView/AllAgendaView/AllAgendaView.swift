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
