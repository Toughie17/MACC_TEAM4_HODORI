//
//  Agenda.swift
//  Hodori
//
//  Created by 송지혁 on 11/5/23.
//

import Foundation

struct Agenda: Identifiable, Hashable {
    var title: String
    var detail: [String]
    var isComplete: Bool = false
    var id = UUID().uuidString
}

// 얘를 계속 넘겨줌
//@State agendas [Agenda]
//
//
////세부 회의 안건은
//@State current Title
//@State current detail
//
//agendas.append(
