//
//  StartView.swift
//  Hodori
//
//  Created by 송지혁 on 11/12/23.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var meetingManager: MeetingManager
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isHistoryNavigationButtonClicked = false
    @State private var isAgendaSettingNavigationButtonClicked = false
    
    private var today: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        return dateFormatter.string(from: currentDate)
    }
    
    var lastMeeting: Meeting {
        guard let lastMeeting = meetingManager.meetingHistory.first else { return
            Meeting(agendas: [.init(title: "", detail: [""])], startDate: Date()) }
        return lastMeeting
    }
    
    private var isMeetingExist: Bool {
        guard let agenda = lastMeeting.agendas.first else { return false }
        return agenda.title.isNotEmpty
    }
    
    var body: some View {
        GeometryReader { proxy in
            Color.white
                .ignoresSafeArea()
            
            Color.gray10
                .ignoresSafeArea()
                .frame(height: proxy.size.height / 3.22)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(today)
                        .font(.pretendRegular20)
                        .foregroundStyle(Color.gray3)
        
                    Spacer()
                    historyNavigationButton
                }
                .padding(.bottom, 2)
                
                header
                    .padding(.bottom, 40)
                
                if isMeetingExist {
                    MeetingCard(.last, meeting: lastMeeting)
                } else {
                    placeholder
                }
                Spacer()
                meetingStartButton
                    .padding(.bottom, 36)
                
            }
            .ignoresSafeArea(edges: .bottom)
            .padding(.horizontal, 24)
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            isHistoryNavigationButtonClicked = false
            isAgendaSettingNavigationButtonClicked = false
        }
    }
    
    private var header: some View {
        Text(headerText)
            .font(.pretendBold32)
            .foregroundStyle(.black)
    }
    
    private var historyNavigationButton: some View {
        Image(systemName: "clock.arrow.circlepath")
            .font(.system(size: 24))
            .foregroundStyle(.black)
            .onTapGesture {
                navigationManager.screenPath.append(.history)
                isHistoryNavigationButtonClicked = true
            }
            .disabled(isAgendaSettingNavigationButtonClicked)
    }
    
    private var meetingStartButton: some View {
        Button {
            navigationManager.screenPath.append(.agendaSetting)
            isAgendaSettingNavigationButtonClicked = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                
                Text("새 회의 시작하기")
                    .font(.pretendBold16)
                    .foregroundStyle(.white)
                    .padding(.vertical, 18)
                    .padding(.trailing, 14)
            }
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray1)
            }
        }
        .disabled(isHistoryNavigationButtonClicked)
    }
    
    private var headerText: String {
        isMeetingExist ? "회의를 시작 해볼까요?" : "오늘 회의, 잇죠?"
    }
    
    private var placeholder: some View {
        Text("이전 회의 내역이 아직 없어요\n새 회의를 시작해보세요")
            .font(.pretendRegular16)
            .foregroundStyle(Color.gray2)
            .lineSpacing(1.4)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .multilineTextAlignment(.center)
            .cardBackground(opacity: 0.1, radius: 20, y: 4)
    }
}

#Preview {
    StartView()
        .environmentObject(MeetingManager())
        .environmentObject(NavigationManager())
}
