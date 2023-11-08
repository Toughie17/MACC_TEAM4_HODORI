//
//  TestMeetingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct TestMeetingView: View {
//    @EnvironmentObject var navigationManager: NavigationManager
    
    @State var agendas: [Agenda]
    
    let backColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593991637, alpha: 1)

    @State var showAlert: Bool = false
    @State var alert: Alert?
    
    @State var showSheet: Bool = false
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        //MARK: 네비게이션 스택 테스트
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    //MARK: 타이머 뷰
                    tempTimerView
                        .padding(.top, 24)
                    
                    TabView(selection: $selectedTab) {
                        ForEach(agendas.indices, id: \.self) { index in
                            //MARK: 내부 탭뷰 구현 ----
                            TabViewCell(agenda: agendas[index], index: index)
                        }
                    }
                    .frame(height: 480)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .padding(.top, 16)
                    
                    //MARK: 커스텀 페이지 컨트롤 들어올 자리
                    CustomPageControl(selectedTab: $selectedTab, totalTabs: agendas.count)
                        .padding(.bottom, 12)

                    // 타이머 및 안건 완료 버튼 박스
                    
                    buttonBox
                    
                }
                .padding(.horizontal, 20)
                .zIndex(1)
                
                if showAlert {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .zIndex(2)
                    
                    MeetingAlert(showAlert: $showAlert)
                        .transition(.scale)
                        .zIndex(3)
                }
                
            }
            .sheet(isPresented: $showSheet, content: {
                AllAgendaView(showSheet: $showSheet, agendas: $agendas, currentTab: $selectedTab)
            })
            .navigationBarBackButtonHidden()
            .navigationBarTitle("지금은 회의 중", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        showSheet = true
                    } label: {
                        Text("전체안건")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        withAnimation(.bouncy) {
                            showAlert = true
                        }
                    } label: {
                        Text("회의 종료")
                    }

                }
            }
            //MARK: 네비게이션 스택 테스트
        }
    }
}

extension TestMeetingView {
    private var tempTimerView: some View {
        RoundedRectangle(cornerRadius: 22)
            .fill(.orange)
            .frame(height: 80)
    }
    
    //나중에 스트럭트로 따로 빼주는게 좋을듯함
    private var buttonBox: some View {
        HStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(.gray)
                .frame(width: 70, height: 56)
                .padding(.trailing, 12)
            
            Button {
                agendas[selectedTab].isComplete = true
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(agendas[selectedTab].isComplete ? .gray : .blue)
                    HStack(spacing: 0) {
                        Spacer()
                        Text("안건 완료")

                        if agendas[selectedTab].isComplete {
                            Image(systemName: "checkmark")
                                .padding(.leading, 10)
                        }
                        Spacer()
                    }
                }
                .foregroundStyle(.white)
                .frame(height: 56)
            }
            .disabled(agendas[selectedTab].isComplete)
        }
    }
    
    
    
}

struct TabViewCell: View {
    let agenda: Agenda
    let index: Int
    
    var body: some View {
        ZStack {
            // 배경
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.cyan))
            //내부 스택
            VStack(alignment: .leading, spacing: 0) {
                //첫 줄(도형, 안건)
                HStack {
                    if agenda.isComplete {
                        Image(systemName: "checkmark")
                    } else {
                        Image(systemName: "circle")
                    }
                    //
                    Text(agendaTitle(forIndex: index))
                        .padding(.leading, 12)
                    Spacer()
                }
                .padding(.bottom, 12)
                // 큰 안건 제목
                Text(agenda.title)
                    .padding(.bottom, 20)
                
                ForEach(agenda.detail, id: \.self) { detail in
                    HStack(spacing: 0) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 3, height: 3)
                        Text(detail)
                            .padding(.leading, 8)
                    }
                    .padding(.bottom, 4)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
        }
    }
    
    func agendaTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫번째 안건"
        case 1:
            return "두번째 안건"
        case 2:
            return "세번째 안건"
        case 3:
            return "네번째 안건"
        case 5:
            return "다섯번째 안건"
        case 6:
            return "여섯번째 안건"
        case 7:
            return "일곱번째 안건"
        case 8:
            return "여덟번째 안건"
        case 9:
            return "아홉번째 안건"
        default:
            return "알 수 없는 안건"
        }
    }
}

struct CustomPageControl: View {
    @Binding var selectedTab: Int
    let totalTabs: Int

    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                ForEach(0..<totalTabs, id: \.self) { index in
                    Circle()
                        .fill(index == selectedTab ? Color.black : Color.gray) // 선택된 페이지는 파란색, 그 외에는 회색
                        .frame(width: 8, height: 8) // 원의 크기 조정
                        .padding(8) // 원 사이의 간격 조정
                        .onTapGesture {
                            selectedTab = index
                        }
                }
            }
        }
        .frame(height: 44)
    }
}

#Preview {
    TestMeetingView(agendas: [
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
        Agenda(title: "안건4", detail: [],isComplete: true),
        Agenda(title: "안건5", detail: [],isComplete: false)
    ])
}
