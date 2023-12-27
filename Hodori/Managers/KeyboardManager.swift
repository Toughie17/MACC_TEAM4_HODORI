//
//  KeyboardHeightManager.swift
//  Hodori
//
//  Created by 송지혁 on 11/11/23.
//

import SwiftUI
import UIKit

final class KeyboardManager: ObservableObject {
    enum KeyboardState {
        case willShow
        case willChange
        case didShow
        case willHide
        
        var state: NSNotification.Name {
            switch self {
            case .willShow:
                UIResponder.keyboardWillShowNotification
            case .willChange:
                UIResponder.keyboardWillChangeFrameNotification
            case .didShow:
                UIResponder.keyboardDidShowNotification
            case .willHide:
                UIResponder.keyboardWillHideNotification
            }
        }
    }
    
    @Published var keyboardHeight: CGFloat = 0
    @Published var isKeyboardDissmissed = true
    
    init() {
        observeKeyboardNotification()
    }
    
    private func observeKeyboardNotification() {
        updateKeyboardHeightWhen(.willShow)
        updateKeyboardHeightWhen(.willChange)
        updateKeyboardStateWhen(.didShow)
        updateKeyboardStateWhen(.willHide)
    }
    
    private func updateKeyboardHeightWhen(_ keyboardState: KeyboardState) {
        NotificationCenter.default.addObserver(forName: keyboardState.state, object: nil, queue: .main) { notification in
            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = value.height
            withAnimation(.linear) {
                self.keyboardHeight = height
            }
        }
    }
    
    private func updateKeyboardStateWhen(_ keyboardState: KeyboardState) {
        NotificationCenter.default.addObserver(forName: keyboardState.state, object: nil, queue: .main) { notification in
            withAnimation(.linear(duration: 0.1)) {
                switch keyboardState {
                case .didShow:
                    self.isKeyboardDissmissed = false
                case .willHide:
                    self.isKeyboardDissmissed = true
                default: break
                }
            }
        }
    }
}
