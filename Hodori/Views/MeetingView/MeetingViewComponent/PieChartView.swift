//
//  PieChartView.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct PieChartView: View {
    
    let agendas: [Agenda]
    
    var degreePerAgenda: Double {
        Double(360 / (agendas.count))
    }
    
    var doneCount: Double {
        Double(agendas.filter { $0.isComplete == true}.count)
    }
    
    var startPercent: CGFloat = 0
    
    var endPercent: CGFloat  {
        doneCount == 0 ? 0.01 : (CGFloat(degreePerAgenda * doneCount) - 0.01)
    }
    
    var backgroundColor: Color = Color.primaryBlue
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(.clear)
                Circle()
                    .stroke(Color.primaryBlue, lineWidth: 3)
                
                Path { path in
                    let size = geometryProxy.size
                    let center = CGPoint(x: size.width / 2.0,
                                         y: size.height / 2.0)
                    let radius = min(size.width, size.height) / 2.0
                    path.move(to: center)
                    path.addArc(center: center,
                                radius: radius,
                                startAngle: .init(degrees: Double(self.startPercent)),
                                endAngle: .init(degrees: Double(self.endPercent)),
                                clockwise: false)
                }
                .rotation(.init(degrees: 270))
                .foregroundColor(backgroundColor)
                
                .frame(width: geometryProxy.size.width,
                       height: geometryProxy.size.height,
                       alignment: .center)
            }
        }
    }
}

#Preview {
    PieChartView(agendas: [
        Agenda(title: "안건1", detail: [], isComplete: true),
        Agenda(title: "안건2", detail: [], isComplete: false),
        Agenda(title: "안건3", detail: [], isComplete: false),
        Agenda(title: "안건4", detail: [], isComplete: false),
    ])
}
