//
//  AllAgendaView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct AllAgendaView: View {
    
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
                
                
                
                
                
                
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // Handle button tap
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

#Preview {
    AllAgendaView()
}

