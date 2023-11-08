//
//  PrioritySettingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PrioritySettingView: View {
//    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.dismiss) private var dismiss
    //MARK: 모크데이터
    @State var agendas: [Agenda] = [
        Agenda(title: "춘식이의 고구마",
               detail: [
                "감자",
                "계란",
                "닭가슴살",
                "돈까스",
                "라멘"
        ], isComplete: false),
        Agenda(title: "춘식이의 파자마", detail: [],isComplete: false),
        Agenda(title: "제주도 감귤", detail: [],isComplete: false),
        Agenda(title: "참서리 제육볶음", detail: [],isComplete: false),
        Agenda(title: "커미 아메리카노", detail: [],isComplete: false),
        Agenda(title: "메로메로 돈까스", detail: [],isComplete: false),
        Agenda(title: "버거킹", detail: [],isComplete: false),
        Agenda(title: "치즈냥이", detail: [],isComplete: false),
        Agenda(title: "메인랩", detail: [],isComplete: false),
        Agenda(title: "체육관", detail: [],isComplete: false)
    ]
    
    @State private var draggingItem: Agenda?
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
//        NavigationStack {
            
            VStack {
                infoText
                    .padding(.top,8)
                cells
                    .padding(.top, 16)
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: backButton)
                    .navigationBarTitle("우선순위 설정", displayMode: .inline)
                
                Spacer()
                
                startButton
//                Spacer()
            }
            .padding(.horizontal,20)
//        }
    }
}

extension PrioritySettingView {
    
    private var infoText: some View {
        Text("진행할 순서에 맞춰 이동하고 회의를 시작해주세요")
            .font(.caption)
    }
    
    private var cells: some View {
        ScrollView {
            ForEach(agendas, id: \.self) { agenda in
                PriorityCell(title: agenda.title)
//                    .padding(.bottom, 8)
                    .draggable(agenda) {
                        EmptyView()
                            .frame(width: 1, height: 1)
                            .onAppear {
                                draggingItem = agenda
                                impactFeedback.impactOccurred()
                            }
                    }
                    .dropDestination(for: Agenda.self) { items, location in
                        draggingItem = nil
                        return true
                    } isTargeted: { status in
                        if let draggingItem, status, draggingItem != agenda {
                            if let sourceIndex = agendas.firstIndex(of: draggingItem),
                               let destinationIndex = agendas.firstIndex(of: agenda) {
                                
                                withAnimation(.bouncy) {
                                    self.agendas.move(fromOffsets: IndexSet(integer: sourceIndex), toOffset: destinationIndex > sourceIndex ? destinationIndex + 1 : destinationIndex)
                                }
                                impactFeedback.impactOccurred()
                            }
                        }
                    }
            }
        }
    }
    
    private var startButton: some View {
        
        NavigationLink {
            MeetingView(agendas: self.agendas)
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue)
                .frame(height: 66)
                .overlay {
                    Text("회의 시작")
                        .foregroundColor(.white)
                }
        }
    }
    
    private var backButton: some View {
        Button {
//            navigationManager.screenPath.removeLast()
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
                .padding(.trailing, 30)
        }
    }
}

#Preview {
    PrioritySettingView()
}
