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
    @State private var keyboardHeight: CGFloat = 0
    @State private var buttonHeight: CGFloat = 0
    
    @State private var selectedAgenda: Agenda = .init(title: "", detail: [""])
    @State private var isKeyboardDissmissed = true
    let autoCorrectionHeight: CGFloat = 57
    
    @Namespace var anchor
    @State private var isAddCellClicked = false
    
    @State private var isFocused: Bool = false
    
    var scrollElement: [Agenda: Bool] {
        [selectedAgenda: isKeyboardDissmissed]
    }
    
    private func updateAgenda(oldAgenda: Agenda, newAgenda: Agenda) {
        guard let index = agendas.firstIndex(where: { $0 == oldAgenda } ) else { return }
        agendas[index] = newAgenda
    }
    
    private var keyboardAvoidance: CGFloat {
        guard isKeyboardDissmissed else { return keyboardHeight - buttonHeight - autoCorrectionHeight }
        return 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollviewProxy in
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(agendas.indices, id: \.self) { index in
                            let agenda = agendas[index]
                            
                            AgendaCell(viewState: .normal, agenda: agenda.title, detailAgendas: agenda.detail, isFocused: $isFocused) { agendaTitle, detailAgendas in
                                if agendaTitle.isEmpty, detailAgendas.filter({ $0 != "" && $0 != "\u{200B}" }).isEmpty {
                                    updateAgenda(oldAgenda: agenda, newAgenda: Agenda(title: agendaTitle, detail: detailAgendas))
                                    agendas.remove(at: index)
                                } else {
                                    updateAgenda(oldAgenda: agenda, newAgenda: Agenda(title: agendaTitle, detail: detailAgendas))
                                }
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    selectedAgenda = agenda
                                }
                            })
                            
                            HStack { Spacer() }
                                .frame(height: 1)
                                .background {
                                    Color.red
                                }
                                .id(agenda.id)
                        }
                        
                        if agendas.count < 10 {
                            AgendaCell(viewState: .add, agenda: "", detailAgendas: [""], isFocused: $isFocused) { agenda, detailAgendas in
                                agendas.append(Agenda(title: agenda, detail: detailAgendas))
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                isAddCellClicked.toggle()
                            })
                        }
                        
                        HStack { Spacer() }
                            .id(anchor)
                        
                    }
                    .onChange(of: scrollElement) { newValue in
                        let selectedAgenda = newValue.first!.key
                        let isKeyboardDismissed = newValue.first!.value
                        
                        guard !isKeyboardDismissed else { return }
                        withAnimation(.easeOut(duration: 0.2)) {
                            scrollviewProxy.scrollTo(selectedAgenda.id, anchor: .bottom)
                        }
                    }
                    .onChange(of: agendas.count) { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollviewProxy.scrollTo(anchor)
                            }
                        }
                    }
                    .onChange(of: isAddCellClicked) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            scrollviewProxy.scrollTo(anchor)
                        }
                    }
                }
            }
            .padding(.top, 27)
            .background {
                Color.clear
                    .contentShape(Rectangle())
            }
            .onTapGesture {
                isFocused.toggle()
            }
            
            Color.clear
                .frame(maxHeight: keyboardAvoidance)

            completeButton
                .padding(.bottom, 42)
        }

        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                withAnimation(.linear) {
                    self.keyboardHeight = height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { notification in
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                withAnimation(.linear) {
                    self.keyboardHeight = height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { notification in
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                withAnimation(.linear) {
                    isKeyboardDissmissed = false
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                withAnimation(.linear(duration: 0.1)) {
                    isKeyboardDissmissed = true
                }
            }
        }
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
