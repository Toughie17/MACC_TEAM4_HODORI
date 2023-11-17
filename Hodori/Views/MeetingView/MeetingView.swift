//
//  TestMeetingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct MeetingView: View {
    
    @State var agendas: [Agenda]
    
    var completedAgendaCount: Int {
        agendas.filter { $0.isComplete }.count }
    
    var leftAgendaCount: Int {
        agendas.count - completedAgendaCount
    }
    @State var sec : Double = 0.0 
    @State var showAlert: Bool = false
    @State var alert: Alert?
    @State var showSheet: Bool = false
    @State var showLottie: Bool = false
    @State var showTimer: Bool = false
    @State var toMeetingEndView: Bool = false
    
    
    @State var selectedTab: Int = 0
    
    @State var showModal: Bool = false

    
    private let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    private let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)
    
    
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                
                Spacer()
                
                if showTimer {
                   tempTimerView
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                }
                mainTabView
                    .padding(.top, 16)
                
                pageControl
                    .padding(.bottom, 12)
                    .padding(.horizontal, 20)
                
                buttonBox
                    .padding(.horizontal, 20)
            }
            //MARK: 디자인 요청사항 반영 패딩 조정(수정 가능성 존재)
            //                .padding(.horizontal, 20)
            .zIndex(1)
            
            if showAlert {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .zIndex(2)
                MeetingAlert(showAlert: $showAlert, toMeetingEndView: $toMeetingEndView, leftAgenda: leftAgendaCount)
                    .transition(.scale)
                    .zIndex(3)
            }
        }
        .sheet(isPresented: $showSheet, content: {
            AllAgendaView(showSheet: $showSheet, agendas: $agendas, currentTab: $selectedTab)
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitle("회의 진행 중", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "list.bullet")
                        .frame(width: 28, height: 22)
                        .foregroundStyle(Color.primaryBlue)
                }
                .disabled(showAlert)
            }
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    mediumHaptic.impactOccurred()
                    withAnimation(.bouncy) {
                        showAlert = true
                        showTimer = false
                    }
                } label: {
                    Text("회의 종료")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.gray2)
                }
                .disabled(showAlert)
                
            }
        }
        .navigationDestination(isPresented: $toMeetingEndView) {
            MeetingEndView(agendas: agendas, completedAgendaCount: completedAgendaCount)
        }
        .sheet(isPresented: $showModal) { 
            TimerSettingView( sec : $sec,showModal: $showModal, showTimer : $showTimer)
                .presentationDetents([.medium]) // 바텀시트 하프모달로 보이게 하기
                .presentationDragIndicator(.visible) // grabber 보이게 하기
                .presentationBackgroundInteraction(
                    .enabled(upThrough: .medium)) // 모달외 클릭했을 시 시트 내려가지 않게 (iOS16.4)
                .presentationCornerRadius(21)
                    // 하프모달 코너래디우스 값 조정(iOS16.4)
//                .onChange(of: showModal, perform: { value in
//                                    // Grabber로 바텀시트를 내릴 때 sec를 0으로 설정
//                                    if !value {
//                                        sec = 0.0
//                                    }
//                                })
            
        }
    }
}

extension MeetingView {
    private var tempTimerView: some View {
                   TimerRunningView(sec: $sec,showTimer: $showTimer)
    }
    
    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            ForEach(agendas.indices, id: \.self) { index in
                MeetingTabViewCell(agenda: agendas[index], index: selectedTab, showLottie: $showLottie)
            }
        }
        .frame(maxHeight: .infinity)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private var pageControl: some View {
        CustomPageControl(selectedTab: $selectedTab, totalTabs: agendas.count)
    }
    
    private var buttonBox: some View {
        HStack(spacing: 12) {
            timerButton
            agendCompleteButton
        }
    }
    
    
    private var timerButton: some View {
        Button {
            mediumHaptic.impactOccurred()
            withAnimation(.bouncy) {
                showModal.toggle()
            }
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 22)
                    .stroke((showModal || showTimer) ? Color.gray5 : Color.gray1, lineWidth: 2)
                    .frame(width: 70, height: 56)
                
                Image(systemName: "stopwatch")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle((showModal || showTimer) ? Color.gray5 : Color.gray1)
                    .frame(width: 29, height: 29)
            }
        }
        .disabled(showModal || showTimer)
    }
    
    private var agendCompleteButton: some View {
        Button {
            heavyHaptic.impactOccurred()
            withAnimation(.bouncy) {
                showLottie = true
                print(selectedTab)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                    showLottie = false
                    updateAgendas()
                }
            }
            
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(showLottie || agendas[selectedTab].isComplete ? .gray : .blue)
                HStack(spacing: 0) {
                    Spacer()
                    Text("안건 완료")
                        .font(.pretendBold20)
                    if showLottie || agendas[selectedTab].isComplete {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .frame(height: 56)
        }
        .disabled(showLottie || agendas[selectedTab].isComplete)
    }
    
    private func updateAgendas() {
        agendas[selectedTab].isComplete = true
        if selectedTab < agendas.count && selectedTab != agendas.count - 1 {
            selectedTab += 1
        }
    }
}

#Preview {
    NavigationStack {
        MeetingView(agendas: [
            Agenda(title: "오늘의 첫번째 회의안건은 이것이 되겠네요",
                   detail: [
                    "세부 회의 안건 1",
                    "세부 회의 안건 2",
                    "세부 회의 안건 3",
                    "세부 회의 안건 4",
                    "세부 회의 안건은 이걸루 끝인가요 마지막"
                   ],
                   isComplete: false),
            Agenda(title: "안건2", detail: [],isComplete: false),
            Agenda(title: "안건3", detail: [],isComplete: false),
            Agenda(title: "안건4", detail: [],isComplete: false),
            Agenda(title: "안건5", detail: [],isComplete: false)
        ])
    }
}
