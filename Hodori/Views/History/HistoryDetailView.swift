//
//  HistoryDetailView.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import SwiftUI

struct HistoryDetailView: View {
    @State private var agendaClick: [(Double, Bool)] = Array(repeating: (0, false), count: 10)
    @Environment(\.dismiss) var dismiss
    let meeting: Meeting
    
    private var totalAgenda: Int {
        meeting.agendas.count
    }
    
    private var completedAgenda: Int {
        meeting.agendas.filter { $0.isComplete == true }.count
    }
    
    private var dayMonthTime: String {
        return dateFormat(meeting.startDate, format: "M월 d일 HH:mm")
    }
    
    private var headerText: String {
        totalAgenda == completedAgenda ? "안건을 모두 완료했어요" : "안건 \(completedAgenda)개를 완료했어요"
    }

    private func dateFormat(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = date
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(edges: .bottom)
            
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 21) {
                    PieChartView(agendas: meeting.agendas)
                        .frame(width: 30, height: 30)
                        .padding(.top, 20)
                    
                    Text(headerText)
                        .font(.pretendBold24)
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.bottom, 33)
                .background {
                    Color.gray10
                        .ignoresSafeArea()
                }
                
                VStack {
                    agendas
                        .padding(.top, 30)
                        .padding(.horizontal, 28)
                }
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationTitle("\(dayMonthTime) 회의")
                
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
    
    private var agendas: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(zip(meeting.agendas.indices, meeting.agendas)), id: \.0) { index, agenda in
                    AgendaCell(state: .detail, agenda: agenda, index: index, meeting: meeting, titleFont: .pretendBold18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    HistoryDetailView(meeting: Meeting(agendas: [Agenda(title: "디비디비딥", detail: ["비기비기닝", "빌리빌리진"])], startDate: Date()))
}
