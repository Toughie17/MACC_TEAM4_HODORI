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

struct AgendaCell: View {
    @State var viewState: ViewState
    
    @State var agenda: String
    @State var detailAgendas: [String]
    @State private var isPlaceHolderCilcked = false
    
    @FocusState private var agendaFocusField: Bool
    @FocusState private var detailAgendaFocusField: Int?
    @Binding var isFocused: Bool
    
    var focus: [Bool: Int?] {
        [agendaFocusField : detailAgendaFocusField]
    }
    
    let nextAgenda: (String, [String]) -> ()
    
    var body: some View {
        
        switch viewState {
        case .placeholder:
            placeHolder
                .onTapGesture {
                    viewState = .add
                }
        default:
            VStack(spacing: 19) {
                HStack(alignment: .top, spacing: 11) {
                    blueCircle
                    VStack(alignment: .leading, spacing: 16) {
                        if viewState == .normal {
                            Text(agenda)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        } else {
                            agendaField
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            detailAgendaFieldList
                        }
                    }
                }
                .padding(.vertical, viewState != .normal ? 20 : 0)
                .background {
                    agendaFocusField == true || detailAgendaFocusField != nil ? RoundedRectangle(cornerRadius: 16).fill(.gray) : RoundedRectangle(cornerRadius: 16).fill(.clear)
                }
                
                if !agenda.isEmpty, viewState == .add {
                    placeHolder
                        .onTapGesture {
//                            agenda.append("\n")
                            detailAgendaFocusField = nil
                            agendaFocusField = false
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                agendaFocusField = true
                            }
                            
                        }
                }
            }
            .onTapGesture {
                if viewState == .normal {
                    viewState = .edit
                    agendaFocusField = true
                }
            }
            .onChange(of: focus) { newValue in
                let agendaFocus = newValue.first!.key
                let detailFocus = newValue.first!.value
                if !agendaFocus && detailFocus == nil {
                    switch viewState {
                    case .add:
                        if agenda.isEmpty, detailAgendas.count == 1, let detail = detailAgendas.first, detail.isEmpty {
                            viewState = .placeholder
                        } else {
                            agenda.append("\n")
                        }
                           
                    case .edit:
                            agenda.append("\n")
                    default: break
                    }
                }
                
                if agendaFocus || detailFocus != nil {
                    switch viewState {
                    case .normal:
                        viewState = .edit
                    default: break
                    }
                }
            }
            .onChange(of: isFocused) { newValue in
                agendaFocusField = false
                detailAgendaFocusField = nil
            }
            .onAppear {
                if let firstValue = detailAgendas.first, firstValue.isEmpty, viewState == .add {
                    agendaFocusField = true
                }
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
    
    private var blueCircle: some View {
        Circle()
            .stroke(.blue, lineWidth: 3)
            .frame(width: 12, height: 12)
            .padding(.leading, 18)
            .padding(.top, 4)
    }
    
    
    private var agendaField: some View {
        TextField("새 안건", text: $agenda, axis: .vertical)
            .font(.system(size: 16))
            .fontWeight(.semibold)
            .focused($agendaFocusField)
            .submitLabel(.next)
            .onChange(of: agenda) { newValue in
                if let firstWord = newValue.first, firstWord == " " {
                    agenda.removeLast()
                }
                if viewState != .add, newValue.isEmpty {
                    nextAgenda(agenda, detailAgendas)
                }
                guard newValue.contains("\n") else { return }
                guard newValue != "\n" else { return agenda.removeAll(where: { $0 == "\n" }) }
                    agenda.removeAll(where: { $0 == "\n" })
                
                    switch viewState {
                    case .edit, .normal:
                        detailAgendas = detailAgendas.filter { $0 != "\u{200B}" }
                        if detailAgendas.count > 1 {
                            detailAgendas = detailAgendas.filter { $0 != "" }
                        }
                        
                        viewState = .normal
                        detailAgendaFocusField = nil
                        agendaFocusField = false
                        
                        
                        nextAgenda(agenda, detailAgendas)
                        
                    default:
                        detailAgendas = detailAgendas.filter { $0 != "\u{200B}" }
                        if detailAgendas.count > 1 {
                            detailAgendas = detailAgendas.filter { $0 != "" }
                        }
                        nextAgenda(agenda, detailAgendas)
                        agenda = ""
                        detailAgendas = [""]
                    }
            }
    }
    
    private var detailAgendaFieldList: some View {
        ForEach(detailAgendas.indices, id: \.self) { index in
            HStack(spacing: 8) {
                Text(viewState == .normal && detailAgendas.first!.isEmpty ? "" : "•")
                TextField("\(index == 0 && detailAgendas.count == 1 ? "세부 회의 안건" : detailAgendas[index])", text: $detailAgendas[index], axis: .vertical)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .focused($detailAgendaFocusField, equals: index)
                    .submitLabel(.next)
                    .disabled(agenda.isEmpty)
            }
            .onChange(of: detailAgendas[index]) { newValue in
                // MARK: 아무것도 추가 안하고 다음 줄로 갈 때
                guard index < detailAgendas.count else { return }
                if newValue == "\u{200B}\n" || newValue == "\n" {
                    detailAgendas[index].removeLast()
                    return
                }
                
                // MARK: 지우고 이전 줄로 갈 때
                if newValue.isEmpty {
                    detailAgendaFocusField = index - 1
                    // MARK: INDEX OUT OF RANGE 의심
                    if index > 0 && index < detailAgendas.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            detailAgendas.remove(at: index)
                        }
                    }
                }
                
                // MARK: 다음 줄로 넘길 때
                guard newValue.contains("\n") else { return }
                detailAgendas[index].removeAll(where: { $0 == "\n" })
                if index + 1 < detailAgendas.count, detailAgendas[index+1] == "\u{200B}" {
                    detailAgendaFocusField = index + 1
                } else if detailAgendas.count < 5, index < 4  {
                    detailAgendas.insert("\u{200B}", at: index+1)
                    detailAgendaFocusField = index + 1
                } else {
                    agenda.append("\n")
                }
            }
        }
        .frame(maxHeight: viewState == .normal && detailAgendas.first!.isEmpty ? 0 : .infinity)
    }
}





// MARK: INDEX OUT OF RANGE 원인
// MARK: 이것만 잡고 자자ㅏㅏ


// MARK: ㅠㅠ
// MARK: 밑에 textfield가 있는 상황에서 그 위 텍스트 필드의 텍스트 중간 쯤에 커서를 두고
// MARK: 반드시 손으로 터치해서 textfield의 포커스를 다시 아래로 넘겨줌
// MARK: 그리고 지워서 포커스를 이동시키면 textfield의 커서가 맨 끝이 아니라 그 전 위치로 돌아감.

