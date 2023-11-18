//
//  MeetingEndView.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct MeetingEndView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var meetingManager: MeetingManager
    
    var agendas: [Agenda]
    let completedAgendaCount: Int
    
    var currentDateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Text("\(currentDateText) 회의")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.black)
                    .padding(.top, 11)
                    .padding(.bottom, 55)
                
                PieChartView(agendas: agendas)
                    .frame(width: 30, height: 30)
                    .padding(.bottom, 20)
                
                Text(agendas.count == completedAgendaCount ? "안건을 모두 완료했어요" : "안건 \(completedAgendaCount)개를 완료했어요")
                    .font(.pretendBold24)
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 50)
                
                if agendas.isNotEmpty {
                    let firstIndex = agendas.startIndex
                    let lastIndex = agendas.index(before: agendas.endIndex)
                    
                    ForEach(agendas.indices, id: \.self) { index in
                        if agendas.count == 1 {
                            AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: false, needLowerLine: false)
                        }
                        else if index == firstIndex {
                            AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: false, needLowerLine: true)
                        }
                        else if index == lastIndex {
                            AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: true, needLowerLine: false)
                        } else {
                            AllAgendaCell(agenda: agendas[index], target: false, needUpperLine: true, needLowerLine: true)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    navigationManager.screenPath = [.start]
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray1)
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .overlay (
                            Text("회의 마치기")
                                .foregroundStyle(Color.white)
                                .font(.pretendBold16)
                        )
                }
                .padding(.bottom, 15)
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            CoreDataManager.shared.save(meeting: Meeting(agendas: agendas, startDate: Date()))
            meetingManager.fetchMeetings()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        MeetingEndView(agendas: [
            Agenda(title: "안건1", detail: [],isComplete: false),
            Agenda(title: "으아아아아아아", detail: [],isComplete: true),
            Agenda(title: "안건3", detail: [],isComplete: false),
            Agenda(title: "안건4", detail: [],isComplete: true),
            Agenda(title: "안건5", detail: [],isComplete: false)
        ], completedAgendaCount: 3)
    }
    .environmentObject(NavigationManager())
    .environmentObject(MeetingManager())
}
