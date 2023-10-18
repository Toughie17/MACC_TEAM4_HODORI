//
//  ConfirmationAlert.swift
//  Hodori
//
//  Created by Eric on 10/17/23.
//

import SwiftUI

struct ConfirmationAlert: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var meetingManager: MeetingManager
    @State private var isStart = false
    let topic: String
    let time: Int
    
    var body: some View {
        VStack(spacing: 0) {
            checkComment
                .padding(.bottom, 58)
            topicBlock
                .padding(.bottom, 24)
            timerBlock
                .padding(.bottom, 84)
            HStack(spacing: 21) {
                fixButton
                startButton
            }
            .padding(.bottom, 37)
        }
        .padding(.horizontal, 40)
        .fullScreenCover(isPresented: $isStart) {
            MeetingView()
        }
    }
    
    private var checkComment: some View {
        VStack(spacing: 0) {
            Image(systemName: "checkmark")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 36))
                .foregroundStyle(Color.pointBlue)
                .padding(.top, 49)
                .padding(.bottom, 25)
            Text("새 회의 시작")
                .font(.pretendMedium20)
                .foregroundStyle(Color.sheetCategoryTextGray)
                .padding(.bottom, 16)
            Text("아래 내용으로 회의를 시작할까요?")
                .font(.pretendSemibold30)
        }
    }
    
    private var topicBlock: some View {
        VStack(spacing: 0) {
            Text("희의 안건")
                .font(.pretendMedium16)
                .foregroundStyle(Color.sheetCategoryTextGray)
                .padding(.top, 30)
                .padding(.bottom, 25)
            Text(topic)
                .font(.pretendMedium24)
                .padding(.bottom, 57)
                
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.sheetBlockBackgroundGray)
        }
    }
    
    private var timerBlock: some View {
        VStack(spacing: 21) {
            Text("예상 회의 시간")
                .font(.pretendMedium16)
                .foregroundStyle(Color.sheetCategoryTextGray)
                .padding(.top, 30)
            Text(time.asTimestamp)
                .font(.system(size: 36))
                .fontWeight(.light)
                .padding(.bottom, 42)
        }
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.sheetBlockBackgroundGray)
        }
    }
    
    private var fixButton: some View {
        Button {
            dismiss()
        } label: {
            Text("수정할래요")
                .font(.pretendSemibold16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pointBlue, lineWidth: 2)
                }
                .contentShape(RoundedRectangle(cornerRadius: 8))
        }
        
        
    }
    
    private var startButton: some View {
        Button {
            startMeeting()
        } label: {
            Text("회의를 시작할게요")
                .font(.pretendSemibold16)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.pointBlue)
                }
        }
    }
    
    private func startMeeting() {
        isStart = true
        meetingManager.createMeeting(meeting: Meeting(topic: topic, expectedTime: meetingManager.startTime()))
    }
}

struct ConfirmationAlert_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationAlert(topic: "", time: 1)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


