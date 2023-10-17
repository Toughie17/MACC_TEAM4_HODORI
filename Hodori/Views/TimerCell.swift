//
//  TimerComponent.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct TimerCell: View {
    @EnvironmentObject var meetingManager: MeetingManager
    var body: some View {
        VStack(spacing: 38) {
            Text("남은 회의 시간")
                .font(.pretendRegular30)
                .foregroundStyle(Color.meetingViewCategoryTextGray)
            
            HStack {
                cancelButton
                Spacer()
                Text(meetingManager.timer.secondsToCompletion.asTimestamp)
                    .font(.system(size: 96))
                    .fontWeight(.light)
                Spacer()
                switch meetingManager.timer.state {
                case .active:
                    pauseButton
                case .paused:
                    resumeButton
                case .resumed:
                    pauseButton
                case .cancelled:
                    resumeButton
                }
            }
        }
    }
    
    private var pauseButton: some View {
        Button {
            meetingManager.timer.state = .paused
        } label: {
            Image(systemName: "pause.fill")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 36))
                .foregroundStyle(Color.pauseButtonRed)
                .padding(32)
        }
        .background {
            Circle()
                .stroke(lineWidth: 2)
                .fill(Color.pauseButtonRed)
                
        }
        
        
    }
    
    private var cancelButton: some View {
        Button {
            meetingManager.timer.state = .cancelled
        } label: {
            Image(systemName: "stop.fill")
        }
        
    }
    
    private var resumeButton: some View {
        Button {
            meetingManager.timer.state = .resumed
        } label: {
            Image(systemName: "play.fill")
        }
        
    }
}
