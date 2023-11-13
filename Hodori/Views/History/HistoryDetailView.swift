//
//  HistoryDetailView.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import SwiftUI

struct HistoryDetailView: View {
    @State private var agendaClick: [(Double, Bool)] = Array(repeating: (0, false), count: 10)
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.dismiss) var dismiss
    let meeting: Meeting
    
    private var totalAgenda: Int {
        meeting.agendas.count
    }
    
    private var completedAgenda: Int {
        meeting.agendas.filter { $0.isComplete == true }.count
    }
    
    var body: some View {
        VStack {
            PieChartView(agendas: meeting.agendas)
                .frame(width: 45, height: 45)
                .padding(.top, 44)
                .padding(.bottom, 20)
            
            Text("\(totalAgenda)개 중 \(completedAgenda)개를 완료했어요")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.black)
                .padding(.bottom, 20)
            
            agendas
                .padding(.top, 30)
                .padding(.horizontal, 28)
        }
        .navigationTitle("\(meeting.title) 회의")
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
    
    private var agendas: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(zip(meeting.agendas.indices, meeting.agendas)), id: \.0) { index, agenda in
                    HStack(alignment: .top, spacing: 16) {
                            Image(systemName: agenda.isComplete ? "checkmark" : "circle")
                                .foregroundStyle(agenda.isComplete ? .blue : .gray)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(agenda.title)
                                    
                                    Spacer()
                                    
                                    if let firstAgenda = agenda.detail.first, firstAgenda.isNotEmpty {
                                        Image(systemName: "chevron.down")
                                            .foregroundStyle(agenda.isComplete ? .gray : .black)
                                            .rotationEffect(Angle(degrees: agendaClick[index].0))
                                            .onTapGesture {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    agendaClick[index].0 += 180
                                                    agendaClick[index].1.toggle()
                                                }
                                            }
                                    }
                                }
                                
                                if agendaClick[index].1 {
                                    VStack(alignment: .leading, spacing: 4) {
                                        ForEach(agenda.detail, id: \.self) { detailAgenda in
                                            HStack(spacing: 0) {
                                                Text("• ")
                                                Text("\(detailAgenda)")
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.5)
                                            }
                                            .font(.system(size: 14))
                                            .foregroundStyle(.gray)
                                            .opacity(0.8)
                                            
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    
                    Divider()
                }
            }
        }
    }
}

#Preview {
    HistoryDetailView(meeting: Meeting(agendas: [Agenda(title: "디비디비딥", detail: ["비기비기닝", "빌리빌리진"])], startDate: Date()))
}
