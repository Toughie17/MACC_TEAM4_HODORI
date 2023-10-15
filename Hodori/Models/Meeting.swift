//
//  Meeting.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import Foundation

struct Meeting: Identifiable, Hashable {
    let topic: String
    var startDate: Date? = nil
    var endDate: Date? = nil
    let description: String
    var meetingTime: DateComponents? {
        Calendar.current.dateComponents([.hour, .minute, .second], from: startDate ?? Date(), to: endDate ?? Date())
    }
    var id = UUID().uuidString
}
