//
//  MeetingEndView.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct MeetingEndView: View {
    
    var agendas: [Agenda]
    let completedAgendaCount: Int
    
    var currentDateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(currentDateText) 회의")
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.top, 11)
                    .padding(.bottom, 44)
                
                PieChartView(agendas: agendas)
                    .padding(.bottom, 26)
                
                VStack {
                    Text("\(agendas.count)개 중에 \(completedAgendaCount)개 안건을")
                    Text("완료했어요")
                }
                .font(.pretendBold20)
                .padding(.bottom, 56)
                
                ForEach(agendas.indices, id: \.self) { index in
                    AllAgendaCell(agenda: agendas[index], target: false)
                }
                
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
                                .font(.pretendBold20)
                        )
                }
                .padding(.bottom, 21)
            }
        }
        .padding(.horizontal, 44)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MeetingEndView(agendas: [
        Agenda(title: "이전 회의 안건 첫번째는 이걸로 할게요", detail: [],isComplete: false),
        Agenda(title: "안건2", detail: [],isComplete: false),
        Agenda(title: "안건3", detail: [],isComplete: false),
        Agenda(title: "안건4", detail: [],isComplete: true),
        Agenda(title: "안건5", detail: [],isComplete: false)
    ], completedAgendaCount: 1)
}
