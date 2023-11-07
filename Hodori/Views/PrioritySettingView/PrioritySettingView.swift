//
//  PrioritySettingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PrioritySettingView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    //MARK: 모크데이터
    @State var agendas: [Agenda] = [Agenda(title: "안건1", detail: []),Agenda(title: "안건2", detail: []),Agenda(title: "안건3", detail: []),Agenda(title: "안건4", detail: []),Agenda(title: "안건5", detail: []),Agenda(title: "안건6", detail: []),Agenda(title: "안건7", detail: []),Agenda(title: "안건8", detail: []),Agenda(title: "안건9", detail: []),Agenda(title: "안건10", detail: [])]
    
    @State private var draggingItem: Agenda?
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
//        NavigationStack {
            
            VStack {
                infoText
                    .padding(.top,8)
                cells
                    .padding(.top)
                
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: backButton)
                    .navigationBarTitle("우선순위 설정", displayMode: .inline)
                
                Spacer()
                
                startButton
                    .padding(.top, 38)
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
        ForEach(agendas, id: \.self) { agenda in
            PriorityCell(title: agenda.title)
            
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
    
    private var startButton: some View {
        
        NavigationLink {
//            BindingView(cells: agendas)
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
            navigationManager.screenPath.removeLast()
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
