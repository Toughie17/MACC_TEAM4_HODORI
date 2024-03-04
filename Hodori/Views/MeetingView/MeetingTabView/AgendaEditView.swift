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
        VStack (alignment: .leading) {
            HStack {
                cancelBtn
                Spacer()
                headLineText
                Spacer()
                CompleteBtn
            }
        }
            Spacer()
            
            // 안건, 세부안건 섹션
            VStack {
                VStack {
                    AgendaTitleSection
                }
                .padding(.leading, 24)

                VStack {
                    if agenda.detail != [""] {
                        ForEach(agenda.detail, id: \.self) { detail in
                            HStack(spacing: 0) {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 3, height: 3)
                                    .padding(.trailing, 8)
                                
                                Text(detail)
                                    .font(.pretendRegular16)
                                    .lineLimit(1)
                            }
                            .foregroundStyle(agenda.isComplete ? Color.gray7 : Color.gray2)
                            .padding(.bottom, 8)
                        }
                    } else {
                        EmptyView()
                    }
                    Spacer()
                }
            }
        
            .onAppear {
                editedTitle = agenda.title
                editedDetails = agenda.detail
            }
        }
    }

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
                    .foregroundStyle(Color.primaryBlue)
                    .padding(.top, 30)
                    .padding(.trailing, 24)
                    .padding(.bottom, 25)
            }
        }
    private var AgendaTitleSection: some View {
        TextField("안건을 수정하세요", text: $agenda.title)
            .font(.pretendBold24)
            .foregroundStyle(Color.black)
            .onAppear{
                isFocused = true
            }
            .onTapGesture {
                isFocused.toggle()
            }
            .focused($isFocused)
    }
    
    func resetChanges() {
        agenda.title = editedTitle
        agenda.detail = editedDetails
    }
}


//#Preview {
//    AgendaEditView(agenda: $agenda, showEditModal: Binding.constant(false))
//}
