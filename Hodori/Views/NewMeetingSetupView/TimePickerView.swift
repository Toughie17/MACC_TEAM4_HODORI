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
                        Text("\(timeIncrement)")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            
            Text(title)
                .fontWeight(.bold)
            
        }
    }
}
