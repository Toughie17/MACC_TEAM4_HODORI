//
//  HistoryView.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var meetingManager: MeetingManager
    @EnvironmentObject var navigationManager: NavigationManager
    
    private var meetings: [Meeting] {
        meetingManager.meetingHistory
    }
    
    var body: some View {
        ZStack {
            Color.gray10
                .ignoresSafeArea()
            
            if meetings.isEmpty {
                Text("이전 회의 내역이 아직 없어요")
                    .font(.pretendRegular16)
                    .foregroundStyle(Color.gray2)
                    .navigationTitle("회의 기록")
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                navigationManager.screenPath.removeLast()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(zip(meetings.indices, meetings)), id: \.1) { index, meeting in
                            yearSection(index)
                            MeetingCard(.history, meeting: meeting)
                            
                        }
                    }
                    .padding(.horizontal, 24)
                    .navigationTitle("회의 기록")
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                navigationManager.screenPath.removeLast()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                .background {
                    Color.gray10
                        .ignoresSafeArea()
                }
            }
        }
    }
    
    @ViewBuilder
    private func yearSection(_ index: Int) -> some View {
        Group {
            if index == 0 {
                Text(getFormattedYear(from: meetings[index].startDate))
                    .font(.pretendBold24)
                    .foregroundStyle(.black)
            } else if getFormattedYear(from: meetings[index].startDate) != getFormattedYear(from: meetings[index-1].startDate) {
                Text(getFormattedYear(from: meetings[index].startDate))
                    .font(.pretendBold24)
                    .foregroundStyle(.black)
            }
        }
        .padding(.top, 25)
        .padding(.bottom, 21)
    }
    
    private func getFormattedYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    HistoryView()
}
