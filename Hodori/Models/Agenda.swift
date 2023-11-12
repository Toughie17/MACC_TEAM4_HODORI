//
//  Agenda.swift
//  Hodori
//
//  Created by 송지혁 on 11/5/23.
//

import Foundation

struct Agenda: Identifiable, Hashable, Codable {
    var title: String
    var detail: [String]
    var isComplete: Bool = false
    var id = UUID().uuidString
}
