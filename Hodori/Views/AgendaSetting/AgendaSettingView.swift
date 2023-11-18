//
//  AgendaSettingView.swift
//  Hodori
//
//  Created by 송지혁 on 11/6/23.
//

import SwiftUI

struct AgendaSettingView: View {
    @State private var agendas: [Agenda] = []
    @Environment(\.dismiss) var dismiss
    @StateObject var keyboardManager = KeyboardManager()
    
    @State private var showAlert = false
    
    @State private var buttonHeight: CGFloat = 0
    @State private var selectedAgenda: Agenda = Agenda(title: "", detail: [""])
    
    let autoCorrectionHeight: CGFloat = 57
    
    @State private var isAddCellClicked = false
    @State private var isFocused: Bool = false
    @Namespace var anchor
    
    var scrollElement: [Agenda: Bool] {
        [selectedAgenda: keyboardManager.isKeyboardDissmissed]
    }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
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
                .background {
                    touchableArea
                }
                .onTapGesture {
                    isFocused.toggle()
                }
                
                keyboardArea
                completeButton
                    .padding(.bottom, 36)
                    .padding(.horizontal, 24)
            } // VStack
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("안건 작성하기")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showAlert = true
                        isFocused.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    }
                }
            }
            
            if showAlert {
                Color.black
                    .opacity(0.7)
                    .overlay {
                        warningAlert
                    }
                    .ignoresSafeArea()
            }
        }
    }
    
    private var touchableArea: some View {
        Color.clear
            .contentShape(Rectangle())
    }
    
    private func updateAgenda(oldAgenda: Agenda, newAgenda: Agenda) {
        guard let index = agendas.firstIndex(where: { $0 == oldAgenda } ) else { return }
        agendas[index] = newAgenda

    }
    
    private var agendaList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(zip(agendas.indices, agendas)), id: \.0) { index, agenda in
                AgendaView(viewState: .normal, agenda: agenda.title, detailAgendas: agenda.detail, currentIndex: index, isFocused: $isFocused) { agendaTitle, detailAgendas in
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
    }
    
    private var agendaAddCell: some View {
        AgendaView(viewState: .add, agenda: "", detailAgendas: [""], currentIndex: agendas.endIndex-1, isFocused: $isFocused) { agenda, detailAgendas in
                agendas.append(Agenda(title: agenda, detail: detailAgendas))
            }
            .simultaneousGesture(TapGesture().onEnded {
                isAddCellClicked.toggle()
            })
    }
    
    private var agendaField: some View {
        VStack(alignment: .leading, spacing: 0) {
            agendaList
            
            if agendas.count < 10 {
                agendaAddCell
            }
            
            HStack { Spacer() }
                .id(anchor)
        }
        .padding(.top, 20)
    }
    
    private var completeButton: some View {
        NavigationLink {
            PrioritySettingView(agendas: $agendas)
        } label: {
            HStack(spacing: 14) {
                Image("checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 10)
                    .foregroundStyle(.white)
                
                Text("작성 완료")
                    .font(.pretendBold16)
                    .foregroundStyle(.white)
                    .padding(.trailing, 15)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(!agendas.contains(where: { $0.title == "" }) && agendas.count > 0 ? Color.gray1 : .gray)
                    .shadow(color: .white, radius: 10, x: 0, y: -15) 
            }
        }
        .buttonStyle(CustomButton())
        .disabled(agendas.contains(where: { $0.title == "" }) || agendas.count <= 0)
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

// MARK: WarningAlert
extension AgendaSettingView {
    private var warningAlert: some View {
        VStack(spacing: 0) {
            alertText
            
            divider
            
            alertButton
        }
        .aspectRatio(1.45, contentMode: .fit)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .padding(.horizontal, 54)
        
    }
    
    private var alertText: some View {
        VStack(spacing: 0) {
            Text("뒤로 가시겠어요?")
                .font(.pretendBold20)
                .foregroundStyle(.black)
                .padding(.bottom, 16)
            
            Text("페이지 이탈 시\n작성했던 내용이 모두 삭제돼요")
                .font(.pretendRegular16)
                .foregroundStyle(Color.gray4)
                .multilineTextAlignment(.center)
                .lineSpacing(1.4)
        }
        .padding(.top, 35)
        .padding(.bottom, 29)
        .layoutPriority(1)
    }
    
    private var divider: some View {
        Rectangle()
            .fill(Color.gray9)
            .frame(height: 1)
    }
    
    private var alertButton: some View {
        HStack {
            Text("취소")
                .font(.pretendMedium16)
                .foregroundStyle(Color.gray3)
                .center(.horizontal)
                .contentShape(Rectangle())
                .onTapGesture {
                    showAlert = false
                }
            
            Rectangle()
                .fill(Color.gray9)
                .frame(width: 1)
            

            Text("나가기")
                .font(.pretendMedium16)
                .foregroundStyle(Color.gray3)
                .center(.horizontal)
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                }
            
        }
    }
}

// MARK: Keyboard
extension AgendaSettingView {
    private var keyboardAvoidance: CGFloat {
        guard keyboardManager.isKeyboardDissmissed else { return keyboardManager.keyboardHeight - buttonHeight - autoCorrectionHeight }
        return 0
    }
    
    private var keyboardArea: some View {
        Color.clear
            .frame(maxHeight: keyboardAvoidance)
    }
}
