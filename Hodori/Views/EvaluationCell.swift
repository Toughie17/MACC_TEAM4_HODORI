//
//  EvaluationCell.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct EvaluationCell: View {
    let isSelected: Bool
    var evaluate: Evaluate?
    
    var body: some View {
        VStack(spacing: 20) {
            evaluateIcon
            evaluationDescription
        }
    }
    
    private var evaluateIcon: some View {
        Circle()
            .stroke(.white, lineWidth: 2)
            .frame(width: 36, height: 36)
            .overlay {
                Circle()
                    .foregroundStyle(isSelected ? .white : .clear)
                    .frame(width: 36, height: 36)
            }
            .contentShape(Circle())
    }
    
    private var evaluationDescription: some View {
        Text(evaluate?.description ?? "")
            .fontWeight(.semibold)
            .font(.system(size: 12))
    }
}

