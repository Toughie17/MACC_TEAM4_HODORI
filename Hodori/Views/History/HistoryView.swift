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
        ScrollView(showsIndicators: false) {
            ForEach(Array(zip(meetings.indices, meetings)), id: \.0) { index, meeting in
                VStack(alignment: .leading, spacing: 0) {
                    yearSection(index)
                    
                    MeetingCard(.history, meeting: meeting)
                }
                .padding(.bottom, 16)
            }
            .navigationTitle("과거 회의 기록")
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
        .padding(.horizontal, 20)
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder
    private func yearSection(_ index: Int) -> some View {
        if index == 0 {
            Text(getFormattedYear(from: meetings[index].startDate))
                .font(.system(size: 24))
                .bold()
                .padding(.top, 20)
                .padding(.bottom, 16)
        } else if getFormattedYear(from: meetings[index].startDate) != getFormattedYear(from: meetings[index-1].startDate) {
            Text(getFormattedYear(from: meetings[index].startDate))
                .font(.system(size: 24))
                .bold()
                .padding(.top, 20)
                .padding(.bottom, 16)
        }
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
