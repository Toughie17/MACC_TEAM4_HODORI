//
//  MeetingManager.swift
//  Hodori
//
//  Created by Toughie on 11/6/23.
//

import SwiftUI

final class MeetingManger: ObservableObject {
    @Published var meetingHistory: [Meeting] = []
    @Published var currentMeeting: Meeting?
    
}
