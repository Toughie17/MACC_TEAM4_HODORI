//
//  TestMeetingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct TestMeetingView: View {
    
    @State var agendas = [
        Agenda(title: "안건1", detail: [], isComplete: false),
        Agenda(title: "안건2", detail: [], isComplete: true),
        Agenda(title: "안건3", detail: [], isComplete: false),
        Agenda(title: "안건4", detail: [], isComplete: true),
        Agenda(title: "안건5", detail: [], isComplete: false)
    ]
    
    @State var showAlert: Bool = false
    @State var alert: Alert?
    
    @State var showSheet: Bool = false
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
//        NavigationStack {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(agendas.indices, id: \.self) { index in
                            Text(agendas[index].title)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                    )
                    .frame(height: 600)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .padding(.top, 44)
                    .padding(.horizontal,24)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.bouncy) {
                            showAlert = true
                        }
                    } label: {
                        Text("회의 종료")
                    }
                }
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
                AllAgendaView(showSheet: $showSheet, agendas: self.agendas, currentTab: selectedTab)
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
//                    Button(action: {}, label: {
//                        Text("전체안건")
//                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Text("회의종료")
                    })
                }
            }
//        }
    }
}

#Preview {
    TestMeetingView()
}
