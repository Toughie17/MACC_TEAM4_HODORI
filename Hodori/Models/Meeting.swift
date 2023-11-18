//
//  Meeting.swift
//  Hodori
//
//  Created by 송지혁 on 11/5/23.
//

import Foundation

struct Meeting: Identifiable, Hashable, Codable {
    var agendas: [Agenda]
    var startDate: Date
    var title: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일 H:mm"
        return dateFormatter.string(from: startDate)
    }
    var id = UUID().uuidString
    
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
