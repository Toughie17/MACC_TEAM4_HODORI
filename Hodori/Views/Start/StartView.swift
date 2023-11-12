//
//  StartView.swift
//  Hodori
//
//  Created by 송지혁 on 11/12/23.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var meetingManager: MeetingManger
    @EnvironmentObject var navigationManager: NavigationManager
    
    private var today: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        return dateFormatter.string(from: currentDate)
    }
    
    var lastMeeting: Meeting {
        guard let lastMeeting = meetingManager.meetingHistory.last else { return
            Meeting(agendas: [.init(title: "", detail: [""])], startDate: Date()) }
        return lastMeeting
    }
    
    private var isMeetingExist: Bool {
        guard let agenda = lastMeeting.agendas.first else { return false }
        guard agenda.title.isEmpty else { return true }
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(today)
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                Spacer()
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 20))
                    .onTapGesture {
                        navigationManager.screenPath.append(.history)
                    }
            }
            .padding(.bottom, 12)
            
            header
                .padding(.bottom, 73)
            
            MeetingCard(meeting: lastMeeting)
            
            Spacer()
            
            meetingStartButton
            
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    private var header: some View {
        Text(headerText)
            .font(.system(size: 32))
            .bold()
    }
    
    private var placeholder: some View {
        Text("이전 회의 내역이 아직 없어요\n새 회의를 시작해보세요")
            .font(.system(size: 16))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray)
                    .opacity(0.2)
            }
            .multilineTextAlignment(.center)
    }
    
    private var meetingStartButton: some View {
        Button {
            navigationManager.screenPath.append(.agendaSetting)
        } label: {
            Text("새 회의 시작하기")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue)
                }
                
        }
    }
    
    private var headerText: String {
        isMeetingExist ? "오늘도 힘차게 회의 이어나가기!" : "오늘 회의, 잇죠?"
    }
        
}

#Preview {
    StartView()
        .environmentObject(MeetingManger())
        .environmentObject(NavigationManager())
}
