//
//  TimePickerView.swift
//  Hodori
//
//  Created by Eric on 10/17/23.
//

import SwiftUI

struct TimePickerView: View {
    let title: String
    let range: StrideThrough<Int>
    let binding: Binding<Int>

    var body: some View {
        HStack(spacing: 0) {
            Picker(title, selection: binding) {
                ForEach(Array(range), id: \.self) { timeIncrement in
                    HStack(spacing: 0) {
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            
            Text(title)
                .fontWeight(.bold)
            
        }
    }
}
