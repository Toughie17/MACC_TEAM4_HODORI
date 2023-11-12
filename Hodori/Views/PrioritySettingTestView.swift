//
//  TestView.swift
//  Hodori
//
//  Created by 송지혁 on 11/9/23.
//

import SwiftUI

struct PrioritySettingTestView: View {
    @Binding var agendas: [Agenda]
    
    var body: some View {
        ForEach(agendas) { agenda in
            VStack(alignment: .leading) {
                Text(agenda.title)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.bottom)
                ForEach(agenda.detail, id: \.self) { detail in
                    Text("• \(detail)")
                }
            }
            .padding()
            .background {
                Color.gray
            }
            .padding(.bottom, 15)
        }
    }
}
