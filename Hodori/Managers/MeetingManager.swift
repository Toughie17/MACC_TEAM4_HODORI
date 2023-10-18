//
//  MeetingModel.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import Combine
import SwiftUI

final class MeetingManager: ObservableObject {
    @Published var meetings: [Meeting] = []
    @Published var timer: TimerManager
    @Published var meeting: Meeting?
    
    init(timer: TimerManager) {
        self.timer = timer
        self.timer.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send() }
            .store(in: &cancellables)
        self.meeting = Meeting(topic: "테스트입니다", expectedTime: 600, addedTime: 30, earlyEndingTime: 0, satisfaction: "", review: "", keywords: [], id: UUID().uuidString)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // 미팅 객체를 추가하는 함수
    func createMeeting(meeting: Meeting) {
        self.meeting = meeting
    }
    
    // 미팅 객체를 삭제하는 함수
    func deleteMeeting() {
        self.meeting = nil
    }
    
    func startTime() -> Int {
        timer.startTime
    }
    
    // + a 미팅 객체를 솔팅하는 함수

}
