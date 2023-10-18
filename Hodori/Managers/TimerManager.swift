//
//  TimerManager.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

enum TimerState {
    case active
    case paused
    case resumed
    case cancelled
}

final class TimerManager: ObservableObject {
    
    private var timer = Timer()
    
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 0
    @Published var selectedSecondsAmount = 0
    @Published var state: TimerState? = nil {
        didSet {
            switch state {
            case .cancelled:
                timer.invalidate()
                totalUsedTime = totalTime - secondsToCompletion
                
            case .active:
                startTimer()
                
                secondsToCompletion = startTime
                totalTime = startTime
                currentTime = startTime
                progress = 1.0

            case .paused:
                timer.invalidate()

            case .resumed:
                startTimer()

            case nil:
                progress = 1.0
            }
        }
    }
    
    // MARK: 유저가 회의 생성 시점에 Picker로 생성한 시간.
    var startTime: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60) + selectedSecondsAmount
    }

    // MARK: 유저가 추가한 모든 시간. 처음엔 startTime 값과 같음. 추후에 startTime + addedTime
    @Published var totalTime: Int = 0
    
    // MARK: 실제로 MeetingView에 보여지는 남은 시간. 처음엔 startTime 값과 같음. 추후에 secondsToCompletion + addedTime
    @Published var secondsToCompletion = 0
    
    var currentTime: Int = 0
    
    // MARK: 유저가 시간을 추가했을 때, 이 프로퍼티에 값이 들어감.
    @Published var addedTime: Int = 0 {
        didSet {
            secondsToCompletion += addedTime
            totalTime += addedTime
        }
    }
    
    //MARK: 유저가 실제로 사용한 추가 시간.
    @Published var usedAddedTime: Int = 0
    
    // MARK: 총 소요시간. 딱 유저가 쓴 시간. totalTime - secondToCompletion
    @Published var totalUsedTime: Int = 0
    
    @Published var progress: Float = 1.0
    
    let hoursRange = stride(from: 0, through: 23, by: 1)
    let minutesRange = stride(from: 0, through: 59, by: 5)
    let secondsRange = stride(from: 0, through: 59, by: 1)

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            if self.secondsToCompletion <= 0 {
                self.state = .cancelled
                return
            }
            
            if self.addedTime > 0 {
                self.usedAddedTime += 1
            }
            
            self.secondsToCompletion -= 1
            self.progress = Float(self.secondsToCompletion) / Float(self.currentTime)
        })
    }
    
    func addTime(_ seconds: Int) {
        self.addedTime = seconds
        self.currentTime = seconds
        self.progress = Float(self.secondsToCompletion) / Float(self.currentTime)
    }
}
