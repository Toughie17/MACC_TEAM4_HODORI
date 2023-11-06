//
//  Meeting.swift
//  Hodori
//
//  Created by 송지혁 on 11/5/23.
//

import Foundation

struct Meeting {
    var agendas: [Agenda]
    var startDate: Date
    var title: String
    
    var completionPercentage: Double {
        let totalAgendas = Double(agendas.count)
        let completedAgendas = agendas.filter { $0.isComplete }.count
        if totalAgendas > 0 {
            return Double(completedAgendas) / totalAgendas * 100.0
        } else {
            return 0.0
        }
    }
}
