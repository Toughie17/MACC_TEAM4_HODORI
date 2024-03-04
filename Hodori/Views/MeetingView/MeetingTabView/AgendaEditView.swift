//
//  AgendaEditView.swift
//  Hodori
//
//  Created by Yujin Son on 2/28/24.
//

import SwiftUI

struct AgendaEditView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var showModal : Bool
    let agenda: Agenda

    var body: some View {
            Text("EditView")
//            Text(agenda.title)
//                .foregroundStyle(agenda.isComplete ? Color.gray5 : Color.gray1)
//                .font(.pretendMedium16)
//                .lineLimit(1)
    }
}
#Preview {
    AgendaEditView(showModal: Binding.constant(false), agenda: Agenda(title: "보리야힘들다", detail: []))
}
