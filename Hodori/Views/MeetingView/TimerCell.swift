//
//  TimerComponent.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct TimerCell: View {
    @EnvironmentObject var meetingManager: MeetingManager
    @State private var isStopped = false
    
    var body: some View {
        VStack(spacing: 38) {
            headLine
            HStack {
                cancelButton
                Spacer()
                time
                Spacer()
                interactionButton
            }
        }
        .onChange(of: meetingManager.timer.state) { state in
            if state == .paused || state == .cancelled {
                withAnimation(.default.repeatForever()) {
                    isStopped = true
                }
            } else {
                isStopped = false
            }
        }
    }
    
    private func timeColor() -> Color {
        switch meetingManager.timer.secondsToCompletion {
        case 0...180:
            return .red
        case 181...600:
            return .timeYellow
        case 601...Int.max:
            return .white
        default:
            return.white
        }
    }
    
    private var headLine: some View {
        Text("남은 회의 시간")
            .font(.pretendRegular30)
            .foregroundStyle(Color.meetingViewCategoryTextGray)
    }
    
    private var time: some View {
        Text(meetingManager.timer.secondsToCompletion.asTimestamp)
            .font(.system(size: 96))
            .fontWeight(.light)
            .foregroundStyle(timeColor())
            .opacity(isStopped ? 0 : 1)
    }
    
    private var pauseButton: some View {
        Button {
            meetingManager.timer.state = .paused
        } label: {
            Image("pauseButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }
    
    private var cancelButton: some View {
        Button {
            meetingManager.timer.state = .cancelled
            
        } label: {
            Image("cancelButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }
    
    private var resumeButton: some View {
        Button {
            if meetingManager.timer.state == nil {
                meetingManager.timer.state = .active
            } else {
                meetingManager.timer.state = .resumed
            }
        } label: {
            Image("playButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }
    
    private var interactionButton: some View {
        Group {
            switch meetingManager.timer.state {
            case nil:
                resumeButton
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
