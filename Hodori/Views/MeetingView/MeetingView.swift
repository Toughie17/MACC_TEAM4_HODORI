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
    @State private var sheetContentHieht = CGFloat(359)
    
    
    private let heavyHaptic = UIImpactFeedbackGenerator(style: .heavy)
    private let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)
    
    
    
    var body: some View {
        ZStack {
            Color.gray10.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                if showTimer {
                    tempTimerView
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                }
                
                mainTabView
                    .padding(.top, 20)
                    .disabled(showLottie)
                
                pageControl
                    .padding(.bottom, 12)
                    .padding(.horizontal, 24)
                
                buttonBox
                    .padding(.horizontal, 24)
            }
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
                        .frame(width: 27, height: 22)
                        .foregroundStyle(Color.gray2)
                }
                .disabled(showAlert || showLottie)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                    mediumHaptic.impactOccurred()
                    withAnimation(.bouncy) {
                        showAlert = true
                    }
                } label: {
                    Text("회의 종료")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.gray2)
                }
                .disabled(showAlert || showLottie)
            }
        }
        .navigationDestination(isPresented: $toMeetingEndView) {
            MeetingEndView(agendas: agendas, completedAgendaCount: completedAgendaCount)
        }
        .sheet(isPresented: $showModal) { 
            TimerSettingView( sec : $sec,showModal: $showModal, showTimer : $showTimer)
                .presentationDetents([.height(sheetContentHieht)])
                .presentationDragIndicator(.visible)
                .onDisappear {
                    sec = 0.0
                }
        }
    }
}

extension MeetingView {
    private var tempTimerView: some View {
        TimerRunningView(sec: $sec,showTimer: $showTimer)
    }
    
    private var mainTabView: some View {
        let firstIndex = agendas.startIndex
        let lastIndex = agendas.index(before: agendas.endIndex)
        
        return TabView(selection: $selectedTab) {
            ForEach(agendas.indices, id: \.self) { index in
                
                if index == firstIndex {
                    MeetingTabViewCell(agenda: agendas[index], index: selectedTab, showLottie: $showLottie, needLeftLine: false, needRightLine: true)
                } else if index == lastIndex {
                    MeetingTabViewCell(agenda: agendas[index], index: selectedTab, showLottie: $showLottie, needLeftLine: true, needRightLine: false)
                } else {
                    MeetingTabViewCell(agenda: agendas[index], index: selectedTab, showLottie: $showLottie, needLeftLine: true, needRightLine: true)
                }
            }
            
        }
        .frame(maxHeight: .infinity)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private var pageControl: some View {
        CustomPageControl(selectedTab: $selectedTab, totalTabs: agendas.count)
    }
    
    private var buttonBox: some View {
        HStack(spacing: 0) {
            timerButton
                .padding(.trailing, 16)
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
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
                    showLottie = false
                    updateAgendas()
                }
            }
        } label: {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(showLottie || agendas[selectedTab].isComplete ? Color.gray5 : Color.gray1)
                HStack(spacing: 0) {
                    Spacer()
                    Text("\(agendaTitle(forIndex: selectedTab))완료")
                        .font(.pretendBold16)
                    
                    if showLottie || agendas[selectedTab].isComplete {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading, 12)
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
        withAnimation(.default) {
            agendas[selectedTab].isComplete = true
            if selectedTab < agendas.count && selectedTab != agendas.count - 1 {
                selectedTab += 1
            }
        }
    }
    
    private func agendaTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫번째 안건"
        case 1:
            return "두번째 안건"
        case 2:
            return "세번째 안건"
        case 3:
            return "네번째 안건"
        case 4:
            return "다섯번째 안건"
        case 5:
            return "여섯번째 안건"
        case 6:
            return "일곱번째 안건"
        case 7:
            return "여덟번째 안건"
        case 8:
            return "아홉번째 안건"
        case 9:
            return "열번째 안건"
        default:
            return "알 수 없는 안건"
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
