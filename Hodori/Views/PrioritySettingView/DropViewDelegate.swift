//
//  DropViewDelegate.swift
//  Hodori
//
//  Created by 정현 on 12/27/23.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    let destinationItem : Agenda
    @Binding var agendas: [Agenda]
    @Binding var draggedAgenda : Agenda?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedAgenda = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedAgenda {
            let fromIndex = agendas.firstIndex(of: draggedAgenda)
            if let fromIndex {
                let toIndex = agendas.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation(.default) {
                        self.agendas.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
