//
//  TimerError.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import Foundation

enum TimerError: LocalizedError {
    case unintended
    
    var errorDescription: String? {
        switch self {
        case .unintended:
            return "의도하지 않은 동작입니다!!"
        }
    }
}
