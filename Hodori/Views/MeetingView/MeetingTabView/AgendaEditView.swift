//
//  AgendaEditView.swift
//  Hodori
//
//  Created by Yujin Son on 2/28/24.
//

import SwiftUI

struct AgendaEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentation
    @StateObject var keyboardManager = KeyboardManager()
    
    @Binding var agenda: Agenda
    @Binding var showEditModal : Bool
    
    @State private var editedTitle: String
    @State private var editedDetails: [String]
    @FocusState private var isFocused: Bool
    
    public init(agenda: Binding<Agenda>, showEditModal: Binding<Bool>) {
        self._agenda = agenda
        self._showEditModal = showEditModal
        _editedTitle = State(initialValue: agenda.wrappedValue.title)
        _editedDetails = State(initialValue: agenda.wrappedValue.detail)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                cancelBtn
                Spacer()
                headLineText
                Spacer()
                CompleteBtn
            }
            
            Spacer()
            
            // 안건, 세부안건 섹션
            VStack(spacing: 0) {
                AgendaTitleSection
            }
            VStack(spacing: 0) {
                ForEach(agenda.detail.indices, id: \.self) { index in
                    if index < 5 {
                        
                        if agenda.detail[index].isEmpty {
                            EmptyView()
                        } else {
                            HStack {
                                Text(bulletPoint)
                                    .padding(.leading, 8)
                                    .foregroundStyle(Color.gray6)
                                TextField("", text: $agenda.detail[index], onCommit: {
                                    if index < agenda.detail.count - 1 {
                                        let nextIndex = index + 1
                                        agenda.detail[nextIndex].append("")
                                    }
                                })                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 6)
                                    .foregroundColor(Color.gray2)
                                    .font(.pretendRegular16)
                                //                                .padding(.bottom, 8)
                            }
                            
                        }
                    }
                }
                Spacer()
            }
            .padding(.leading, 24)
            //            .padding(.top, 29)
            .background(isFocused ? .clear : Color.gray9)
        }
        .onAppear {
            editedTitle = agenda.title
            editedDetails = agenda.detail
        }
    }
}


// MARK: 뷰 익스텐션
extension AgendaEditView {
    private var cancelBtn: some View {
        Button {
            HapticManager.shared.mediumyHaptic()
            withAnimation(.bouncy) {
                resetChanges()
                self.presentation.wrappedValue.dismiss()
            }
        } label: {
            Text("종료")
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(Color.gray2)
                .padding(.top, 30)
                .padding(.leading, 24)
                .padding(.bottom, 25)
        }
    }
    
    private var headLineText: some View {
        Text("안건 수정하기")
            .font(.pretendBold20)
            .foregroundStyle(Color.gray2)
            .padding(.top, 28)
            .padding(.bottom, 23)
    }
    
    private var CompleteBtn: some View {
        Button {
            HapticManager.shared.mediumyHaptic()
            withAnimation(.bouncy) {
                editedTitle = agenda.title
                editedDetails = agenda.detail
                self.presentation.wrappedValue.dismiss()
            }
        } label: {
            Text("완료")
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(agenda.title.isEmpty ? Color.gray2: Color.primaryBlue)
                .padding(.top, 30)
                .padding(.trailing, 24)
                .padding(.bottom, 25)
        }
        .disabled(agenda.title.isEmpty)
    }
    private var AgendaTitleSection: some View {
        TextField("안건을 수정하세요", text: $agenda.title)
            .font(.pretendBold24)
            .foregroundStyle(Color.black)
            .padding(.vertical, 24)
            .padding(.leading, 24)
            .background(isFocused ? Color.gray9 : .clear)
            .overlay(
                HStack {
                    Spacer()
                    textChecker
                        .padding(.trailing, 24)
                }
            )
            .onAppear{
                isFocused = true
            }
            .onTapGesture {
                isFocused.toggle()
            }
            .focused($isFocused)
    }
    
    private var textChecker: some View {
        if isFocused {
            return AnyView(Text("\(agenda.title.count)/16")
                .font(.pretendRegular14)
                .foregroundStyle(Color.gray5))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    
    private func addDetailAgenda() {
        if agenda.detail.count < 5 {
            agenda.detail.append("\n")
        }
    }
    
    private var bulletPoint: String {
        agenda.detail.first!.isEmpty ? "" : "‧"
    }
    
    private func isFirstWordSpace(text: String) -> Bool {
        guard let firstWord = text.first, firstWord == " " else { return false }
        return true
    }
    
    
    func resetChanges() {
        agenda.title = editedTitle
        agenda.detail = editedDetails
    }
}


//#Preview {
//    AgendaEditView(agenda: $agenda, showEditModal: Binding.constant(false))
//}
