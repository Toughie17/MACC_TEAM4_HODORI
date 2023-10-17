//
//  TimerManager.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

final class TimerManager: ObservableObject {
    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
    }
    private var timer = Timer()
    
    var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecondsAmount
    }

    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 0
    @Published var selectedSecondsAmount = 0
    @Published var state: TimerState = .cancelled {
        didSet {
            switch state {
            case .cancelled:
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0

            case .active:
                startTimer()

                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0

                updateCompletionDate()

            case .paused:
                timer.invalidate()

            case .resumed:
                startTimer()
                updateCompletionDate()
            }
        }
    }

    @Published var secondsToCompletion = 0
    @Published var progress: Float = 0.0
    @Published var completionDate = Date.now

    let hoursRange = stride(from: 0, through: 23, by: 1)
    let minutesRange = stride(from: 0, through: 59, by: 5)
    let secondsRange = stride(from: 0, through: 59, by: 1)

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }

            self.secondsToCompletion -= 1
            self.progress = Float(self.secondsToCompletion) / Float(self.totalTimeForCurrentSelection)
            
            if self.secondsToCompletion < 0 {
                self.state = .cancelled
            }
        })
    }

    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
}
