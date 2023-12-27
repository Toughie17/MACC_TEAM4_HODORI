//
//  Agenda.swift
//  Hodori
//
//  Created by 송지혁 on 11/5/23.
//

import SwiftUI

struct Agenda: Identifiable, Hashable, Codable, Transferable {
    var title: String
    var detail: [String]
    var isComplete: Bool = false
    var id = UUID().uuidString
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .content)
        ProxyRepresentation(exporting: \.title)
    }
    
}
extension Agenda {
    static var typeIdentifier: String {
        String(describing: self)
    }
}
