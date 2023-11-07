//
//  MeetingEndView.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct MeetingEndView: View {

    var agendas: [Agenda]
    
    var doneCount: Int {
        (agendas.filter { $0.isComplete == true}.count)
    }
    
    var currentDateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(currentDateText) 회의")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .padding(.bottom, 64)
                
                PieChartView(agendas: agendas)
                    .padding(.bottom, 24)
                
                Text("\(agendas.count)개 중에 \(doneCount)개 안건을 완료했어요")
                    .padding(.bottom, 60)
                
                ForEach(agendas.indices, id: \.self) { index in
                        AllAgendaCell(agenda: agendas[index], target: false)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .overlay (
                        Text("회의 마치기")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                        )
                }
                .padding(.bottom, 42)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MeetingEndView(agendas: [
        Agenda(title: "안건1", detail: [],isComplete: false),
        Agenda(title: "안건2", detail: [],isComplete: false),
        Agenda(title: "안건3", detail: [],isComplete: false),
        Agenda(title: "안건4", detail: [],isComplete: true),
        Agenda(title: "안건5", detail: [],isComplete: false)
    ])
}
