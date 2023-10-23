//
//  MeetingView.swift
//  Hodori
//
//  Created by Eric on 10/17/23.
//

import AVFAudio
import SwiftUI

struct MeetingView: View {
    @Binding var isStart: Bool
    @EnvironmentObject var meetingManager: MeetingManager
    @State private var firstSheetOpen = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                topicCell
                    .padding(.top, 119)
                    .padding(.bottom, 154)
                ProgressBarCell(progress: $meetingManager.timer.progress)
                    .padding(.bottom, 86)
                TimerCell()
                    .padding(.horizontal, 86)
                    .padding(.bottom, 144)
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            meetingManager.timer.state = .active
        }
        .onChange(of: meetingManager.timer.state) { state  in
            if state == .cancelled {
                firstSheetOpen = true
            }
        }
        .sheet(isPresented: $firstSheetOpen, onDismiss: {
            timerStateTo(.paused)
            isStart = false
        }) {
            MeetingEndCheckView(firstSheetOpen: $firstSheetOpen)
        }
    }
    
    private var topicCell: some View {
        VStack(spacing: 47) {
            Text("오늘 회의 안건")
                .font(.pretendRegular30)
                .foregroundStyle(Color.meetingViewCategoryTextGray)
            Text(meetingManager.meeting?.topic ?? "")
                .font(.pretendSemibold64)
                .foregroundStyle(.white)
        }
    }
    
    private func timerStateTo(_ state: TimerState) {
        self.meetingManager.timer.state = state
    }
}

//struct MeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingView()
//    }
//}
