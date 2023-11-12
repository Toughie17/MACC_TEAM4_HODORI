//
//  AgendaCell.swift
//  Hodori
//
//  Created by 송지혁 on 11/6/23.
//

import SwiftUI

enum ViewState {
    case add
    case edit
    case normal
    case placeholder
}

struct AgendaView: View {
    @State var viewState: ViewState
    @State var agenda: String
    @State var detailAgendas: [String]
    @State private var isPlaceHolderCilcked = false
    
    @Binding var isFocused: Bool
    
    @FocusState private var agendaFocusField: Bool
    @FocusState private var detailAgendaFocusField: Int?
    
    private var detailAgendasFrame: CGFloat {
        guard let firstDetailAgenda = detailAgendas.first else { return 0 }
        return viewState == .normal && firstDetailAgenda.isEmpty ? 0 : .infinity
    }
    private var cellBackground: some View {
        isCellFocused ? RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.2)) : RoundedRectangle(cornerRadius: 16).fill(.clear)
    }
    
    var focus: [Bool: Int?] {
        [agendaFocusField : detailAgendaFocusField]
    }
    let nextAgenda: (String, [String]) -> ()
    
    var body: some View {
        switch viewState {
        case .placeholder:
            placeHolder
                .onTapGesture { switchState(to: .add) }
        default:
            agendaCell
                .onAppear {
                    agendaFocusField = true
                }
                .onChange(of: focus) { _ in
                    switch viewState {
                    case .add:
                        guard isNotFocused else { return }
                        guard isCellEmpty else { return addAgenda() }
                        switchState(to: .placeholder)
                    case .edit:
                        guard isNotFocused else { return }
                        addAgenda()
                    case .normal:
                        guard isCellFocused else { return }
                        switchState(to: .edit)
                    default: break
                    }
                }
                .onChange(of: isFocused) { newValue in
                    cancelFocus()
                }
        }
        
    }
    
    private var placeHolder: some View {
        HStack(alignment: .top, spacing: 11) {
            blueCircle
            Text("새 안건")
                .font(.system(size: 16))
                .fontWeight(.semibold)
            
            Spacer()
        }
        .opacity(0.5)
    }
    
    private var agendaCell: some View {
        VStack(spacing: 19) {
            HStack(alignment: .top, spacing: 11) {
                blueCircle
                VStack(alignment: .leading, spacing: 16) {
                        agendaText
                    VStack(alignment: .leading, spacing: 4) {
                        detailAgendaFieldList
                    }
                }
            }
            .padding(.vertical, viewState != .normal ? 20 : 0)
            .background(cellBackground)
            
            if agenda.isNotEmpty, viewState == .add {
                placeHolder
                    .onTapGesture {
                        addAgenda()
                    }
            }
        }
    }
    
    private var blueCircle: some View {
        Circle()
            .stroke(.blue, lineWidth: 3)
            .frame(width: 12, height: 12)
            .padding(.leading, 18)
            .padding(.top, 4)
    }
    
    private var agendaText: some View {
        Group {
            if viewState == .normal {
                Text(agenda)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .onTapGesture {
                        switchState(to: .edit)
                        agendaFocusField = true
                    }
            } else {
                agendaField
                    .layoutPriority(1)
            }
        }
    }
    
    private var detailAgendaFieldList: some View {
        ForEach(detailAgendas.indices, id: \.self) { index in
            HStack(spacing: 8) {
                Text(bulletPoint)
                TextField(detailPlaceholder(current: index), text: $detailAgendas[index], axis: .vertical)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .focused($detailAgendaFocusField, equals: index)
                    .submitLabel(.next)
                    .disabled(agenda.isEmpty)
            }
            .onChange(of: detailAgendas[index]) { newValue in
                // MARK: 아무것도 추가 안하고 다음 줄로 갈 때
                guard index < detailAgendas.count else { return }
                guard isUserTapEnterWithOtherText(to: newValue) else { detailAgendas[index].removeLast()
                    return }
                if newValue == "\u{200B}\n" || newValue == "\n" {
                    detailAgendas[index].removeLast()
                    return
                }
                
                // MARK: 지우고 이전 줄로 갈 때
                if newValue.isEmpty {
                    moveLineTo(index: index - 1)
                    
                    // MARK: index가 배열의 존재하는 위치에 있는지 확인 후, 지운 줄 삭제
                    if index > 0 && index < detailAgendas.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            detailAgendas.remove(at: index)
                        }
                    }
                }
                
                // MARK: 다음 줄로 넘길 때
                guard isUserTapEnter(to: newValue) else { return }
                handleTapActionInDetailAgenda(current: index)

                if isNextLineEmpty(current: index) {
                    moveLineTo(index: index+1)
                } else if isDetailAgendalessThanfive(current: index)  {
                    makeNextLine(current: index)
                    moveLineTo(index: index + 1)
                } else {
                    addAgenda()
                }
            }
        }
        .frame(maxHeight: detailAgendasFrame)
    }
    
    private func resetTextField() {
        agenda = ""
        detailAgendas = [""]
    }
    
    private var agendaField: some View {
        TextField("새 안건", text: $agenda, axis: .vertical)
            .font(.system(size: 16))
            .fontWeight(.semibold)
            .focused($agendaFocusField)
            .submitLabel(.next)
            .onChange(of: agenda) { newValue in
                if isFirstWordSpace(text: newValue) {
                    agenda.removeFirst()
                    return
                }
                
                if viewState != .add, newValue.isEmpty {
                    nextAgenda(agenda, detailAgendas)
                }
                
                guard isUserTapEnter(to: newValue) else { return }
                guard isUserTapEnterWithOtherText(to: newValue) else { return handleTapActionInAgenda() }
                handleTapActionInAgenda()
                eraseEmptyDetailAgendas()
                
                
                // MARK: 두 번째 이상의 안건들은 채워져있는데, 첫 번째 세부 회의 안건이 비어있을 때
                if detailAgendas.count > 1 {
                    detailAgendas = detailAgendas.filter { $0 != "" }
                }
                
                switch viewState {
                case .edit:
                    switchState(to: .normal)
                    cancelFocus()
                    nextAgenda(agenda, detailAgendas)
                    
                default:
                    nextAgenda(agenda, detailAgendas)
                    resetTextField()
                    
                    if !agendaFocusField, detailAgendaFocusField == nil {
                        switchState(to: .placeholder)
                    }
                }
            }
    }
    
    private var isCellFocused: Bool {
        agendaFocusField == true || detailAgendaFocusField != nil
    }
    
    private var isNotFocused: Bool {
        !isCellFocused
    }
    
    private func cancelFocus() {
        agendaFocusField = false
        detailAgendaFocusField = nil
    }
    
    private func isFirstWordSpace(text: String) -> Bool {
        guard let firstWord = text.first, firstWord == " " else { return false }
        return true
    }
    
    private var isCellEmpty: Bool {
        guard let detail = detailAgendas.first else { return false }
        return agenda.isEmpty && detailAgendas.count == 1 && detail.isEmpty
    }
    
    private func addAgenda() {
        agenda.append("\n")
    }
    
    private func switchState(to state: ViewState) {
        viewState = state
    }
    
}


// MARK: DetailAgenda Logics
extension AgendaView {
    private func isNextLineEmpty(current index: Int) -> Bool {
        index + 1 < detailAgendas.count && detailAgendas[index+1] == "\u{200B}"
    }
    
    private func moveLineTo(index: Int) {
        detailAgendaFocusField = index
    }
    
    private func isDetailAgendalessThanfive(current index: Int) -> Bool {
        detailAgendas.count < 5 && index < 4
    }
    
    private func makeNextLine(current index: Int) {
        detailAgendas.insert("\u{200B}", at: index+1)
    }
    
    private func eraseEmptyDetailAgendas() {
        detailAgendas = detailAgendas
            .filter { $0 != "\u{200B}" }
    }
    
    private var bulletPoint: String {
        viewState == .normal && detailAgendas.first!.isEmpty ? "" : "•"
    }
    
    private func detailPlaceholder(current index: Int) -> String {
        "\(index == 0 && detailAgendas.count == 1 ? "세부 회의 안건" : detailAgendas[index])"
    }
    
    private func handleTapActionInDetailAgenda(current index: Int) {
        detailAgendas[index].removeAll(where: { $0 == "\n" })
    }
}

// MARK: Agenda Logic
extension AgendaView {
    private func isUserTapEnter(to text: String) -> Bool {
        text.contains("\n")
    }
    
    private func isUserTapEnterWithOtherText(to text: String) -> Bool {
        text != "\n"
    }
    
    private func handleTapActionInAgenda() {
        agenda.removeAll(where: { $0 == "\n" })
    }
}


// MARK: INDEX OUT OF RANGE 원인
// MARK: 이것만 잡고 자자ㅏㅏ


// MARK: ㅠㅠ
// MARK: 밑에 textfield가 있는 상황에서 그 위 텍스트 필드의 텍스트 중간 쯤에 커서를 두고
// MARK: 반드시 손으로 터치해서 textfield의 포커스를 다시 아래로 넘겨줌
// MARK: 그리고 지워서 포커스를 이동시키면 textfield의 커서가 맨 끝이 아니라 그 전 위치로 돌아감.

