//
//  PrioritySettingView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PrioritySettingView: View {
    
    init(agendas: Binding<[Agenda]>) {
        let appearance = UINavigationBarAppearance()
        let font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        UINavigationBar.appearance().standardAppearance = appearance
        _agendas = agendas
    }
    
    @Environment(\.dismiss) private var dismiss
    @Binding var agendas: [Agenda]
    @State private var draggingItem: Agenda?
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ZStack {
            Color.gray10.ignoresSafeArea()
            
            VStack(spacing: 0) {
                infoText
                    .padding(.top,8)
                    .padding(.bottom, 24)
                cells
                    .padding(.bottom, 12)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                startButton
                    .padding(.bottom, 36)
                    .padding(.horizontal,24)
                
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: backButton)
                    .navigationBarTitle("안건 순서 설정하기", displayMode: .inline)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension PrioritySettingView {
    
    private var infoText: some View {
        Text("안건을 꾹 눌러서 회의 순서에 맞게 이동해 보세요!")
            .foregroundStyle(Color.gray5)
            .font(.pretendRegular14)
    }
    
    private var cells: some View {
        ScrollView {
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
                                
                                withAnimation(.default) {
                                    self.agendas.move(fromOffsets: IndexSet(integer: sourceIndex), toOffset: destinationIndex > sourceIndex ? destinationIndex + 1 : destinationIndex)
                                }
                                impactFeedback.impactOccurred()
                            }
                        }
                    }
                    .scaleEffect(0.97)
            }
        }
    }
    
    private var startButton: some View {
        
        NavigationLink {
            MeetingView(agendas: self.agendas)
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray1)
                .frame(height: 54)
                .overlay {
                    Text("회의 시작")
                        .font(.pretendBold16)
                        .foregroundColor(.white)
                }
        }
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.gray3)
                .font(.system(size: 17, weight: .semibold))
                .padding(.trailing, 30)
        }
    }
}

#Preview {
    NavigationStack {
        PrioritySettingView(agendas:.constant(
            [
                Agenda(title: "으악", detail: []),
                Agenda(title: "으악", detail: []),
                Agenda(title: "으악", detail: []),
                Agenda(title: "으악", detail: []),
                Agenda(title: "으악", detail: []),
                Agenda(title: "으악", detail: [])
            ]
        
        )
                            )
    }
}
