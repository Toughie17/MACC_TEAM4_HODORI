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
        if doneCount == 0 {
            0.01
        } else {
            CGFloat(degreePerAgenda * doneCount) - 0.01
        }
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(.blue)
                Circle()
                    .stroke(Color.blue, lineWidth: 10)
                
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
                                clockwise: true)
                }
                .rotation(.init(degrees: 270))
                .foregroundColor(.white)
                
                .frame(width: geometryProxy.size.width,
                       height: geometryProxy.size.height,
                       alignment: .center)
            }
        }
        .frame(width: 45, height: 45)
    }
}

#Preview {
    PieChartView(agendas: [
        Agenda(title: "안건1", detail: [], isComplete: false),
        Agenda(title: "안건2", detail: [], isComplete: false),
        Agenda(title: "안건3", detail: [], isComplete: false),
        Agenda(title: "안건4", detail: [], isComplete: false),
    ])
}
