//
//  AgendaSettingView.swift
//  Hodori
//
//  Created by 송지혁 on 11/6/23.
//

import SwiftUI

struct AgendaSettingView: View {
    @State private var agendas: [Agenda] = []
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var keyboardManager = KeyboardManager()

    @State private var buttonHeight: CGFloat = 0
    
    @State private var selectedAgenda: Agenda = .init(title: "", detail: [""])
    let autoCorrectionHeight: CGFloat = 57
    @State private var isAddCellClicked = false
    @State private var isFocused: Bool = false
    @Namespace var anchor
    
    var scrollElement: [Agenda: Bool] {
        [selectedAgenda: keyboardManager.isKeyboardDissmissed]
    }
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollviewProxy in
                    agendaField
                        .onChange(of: selectedAgenda) { newValue in
                            guard !keyboardManager.isKeyboardDissmissed else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    scrollviewProxy.scrollTo(selectedAgenda.id, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: agendas.count) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    scrollviewProxy.scrollTo(anchor)
                                }
                            }
                        }
                        .onChange(of: isAddCellClicked) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    scrollviewProxy.scrollTo(anchor)
                                }
                            }
                        }
                }
            } // ScrollView
            .padding(.top, 27)
            .background {
                touchableArea
            }
            .onTapGesture {
                isFocused.toggle()
            }
            
            keyboardArea
            completeButton
                .padding(.bottom, 42)
        } // VStack
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("새 회의 시작하기")
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
        .padding(.horizontal, 20)
    }
    
    private var touchableArea: some View {
        Color.clear
            .contentShape(Rectangle())
    }
    
    private func updateAgenda(oldAgenda: Agenda, newAgenda: Agenda) {
        guard let index = agendas.firstIndex(where: { $0 == oldAgenda } ) else { return }
        agendas[index] = newAgenda

    }
    
    private var keyboardAvoidance: CGFloat {
        guard keyboardManager.isKeyboardDissmissed else { return keyboardManager.keyboardHeight - buttonHeight - autoCorrectionHeight }
        return 0
    }
    
    private var keyboardArea: some View {
        Color.clear
            .frame(maxHeight: keyboardAvoidance)
    }
    
    private var agendaList: some View {
        ForEach(agendas) { agenda in
            
            AgendaView(viewState: .normal, agenda: agenda.title, detailAgendas: agenda.detail, isFocused: $isFocused) { agendaTitle, detailAgendas in
                if agendaTitle.isEmpty, detailAgendas.filter({ $0 != "" && $0 != "\u{200B}" }).isEmpty {
                    updateAgenda(oldAgenda: agenda, newAgenda: Agenda(title: agendaTitle, detail: detailAgendas))
                    agendas.removeAll(where: { $0.title == "" })
                } else {
                    updateAgenda(oldAgenda: agenda, newAgenda: Agenda(title: agendaTitle, detail: detailAgendas))
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    selectedAgenda = agenda
                }
            })
            
            HStack { Spacer() }
                .id(agenda.id)
            }
    }
    
    private var agendaAddCell: some View {
            AgendaView(viewState: .add, agenda: "", detailAgendas: [""], isFocused: $isFocused) { agenda, detailAgendas in
                agendas.append(Agenda(title: agenda, detail: detailAgendas))
            }
            .simultaneousGesture(TapGesture().onEnded {
                isAddCellClicked.toggle()
            })
    }
    
    private var agendaField: some View {
        VStack(alignment: .leading, spacing: 20) {
            agendaList
            
            if agendas.count < 10 {
                agendaAddCell
            }
            
            HStack { Spacer() }
                .id(anchor)
            
        }
    }
    
    private var completeButton: some View {
        NavigationLink {
            PrioritySettingTestView(agendas: $agendas)
        } label: {
            Text("작성 완료")
                .font(.system(size: 16))
                .bold()
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(!agendas.contains(where: { $0.title == "" }) && agendas.count > 0 ? .blue : .gray)
                }
        }
        .buttonStyle(CustomButton())
        .disabled(agendas.contains(where: { $0.title == "" }) || agendas.count < 0)
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        self.buttonHeight = proxy.size.height
                    }
            }
        }
    }
}

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(1)
    }
}

struct AgendaSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaSettingView()
    }
}
