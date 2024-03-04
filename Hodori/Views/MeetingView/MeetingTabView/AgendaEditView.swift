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
//    @Binding var agendas: [Agenda]
//    @Binding var selectedTab: Int
    
//    @State var mainAgenda: String
//    @State var detailAgendas: [String]
    @FocusState private var isFocused: Bool

//    init(agenda: Binding<Agenda>, showEditModal: Binding<Bool>, agendas: Binding<[Agenda]>, selectedTab: Binding<Int>) {
//        _agenda = agenda
//        _showEditModal = showEditModal
//    }
    
    var body: some View {
        VStack (alignment: .leading) {
            // 타이틀 섹션
            HStack {
                Button {
                    withAnimation(.bouncy) {
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
                
                Spacer()
                
                Text("안건 수정하기")
                    .font(.pretendBold20)
                    .foregroundStyle(Color.gray2)
                    .padding(.top, 28)
                    .padding(.bottom, 23)
                
                Spacer()
                
                Button {
                    withAnimation(.bouncy) {
                        showEditModal.toggle()
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
            
                Spacer()
            
            // 안건, 세부안건 섹션
            
            VStack {
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
//            .onTapGesture {
//                isFocused.toggle()
//            }
        }            
        .padding(.leading, 24)


    }
}

//#Preview {
//    AgendaEditView(agenda: $agenda, showEditModal: Binding.constant(false))
//}
