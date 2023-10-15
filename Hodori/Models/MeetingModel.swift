//
//  MeetingModel.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import Combine
import SwiftUI

class MeetingModel: ObservableObject {
    @Published var meetings: [Meeting] = []
    
    @Published var timer: TimerManager
    @Published var meeting: Meeting?
    
    init(timer: TimerManager) {
        self.timer = timer
        self.timer.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send() }
            .store(in: &cancellables)
        self.meetings = sampleData
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func finishMeeting() {
        guard let currentMeetingIndex = meetings.firstIndex(where: { $0.id == meeting?.id }) else { return }
        meetings[currentMeetingIndex].endDate = Date()
        meeting = nil
    }
}

let sampleData: [Meeting] = [
    .init(topic: "토끼와 고양이: 누가 더 귀여운가", description: "고양이와 토끼는 종에 따라 터그 놀이가 가능하다.\n하지만 고양이는 태생적으로 화장실을 구분할 줄 아는 것에 비해 토끼는 아무렇게나 똥을 싸고, 먹는 행위를 한다. 이는 비위가 약한 집사에게 고양이가 더 귀여울 것임을 의미한다."),
    .init(topic: "돌아 강아지는 귀엽다", description: "트리플 악셀을 조지는 강아지가 존재한다. 숏츠에 있다. 이 강아지는 굉장히 귀엽게 돈다.")]
