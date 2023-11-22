//
//  HapticManager.swift
//  Hodori
//
//  Created by Toughie on 11/21/23.
//

import SwiftUI

final class HapticManager {
    static let shared = HapticManager()
    private init() { }
    
    private let heavy = UIImpactFeedbackGenerator(style: .heavy)
    private let medium = UIImpactFeedbackGenerator(style: .medium)
    
    func heavyHaptic() {
        heavy.impactOccurred()
    }
    func mediumyHaptic() {
        medium.impactOccurred()
    }
}
