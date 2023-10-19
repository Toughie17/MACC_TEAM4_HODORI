//
//  NewMeetingSetupView.swift
//  Hodori
//
//  Created by Eric on 10/17/23.
//

import SwiftUI

struct NewMeetingSetupView: View {
    @State private var topic = ""
    @State private var isTextOverLimit = false
    @State private var isChecked = false
    
    @EnvironmentObject var meetingManager: MeetingManager
    @FocusState private var isFocused
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(spacing: 20) {
                topicBlock
                timerBlock
                startButton
            }
            .padding(.top, 90)
            .padding(.horizontal, 241)   
        }
        .ignoresSafeArea(.all)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .sheet(isPresented: $isChecked, content: {
            ConfirmationAlert(topic: topic, time: meetingManager.startTime())
        })
    }
    
    private var topicBlock: some View {
        VStack(spacing: 0) {
            topicIcon
                .padding(.top, 30)
                .padding(.bottom, 17)
            topicComment
                .padding(.bottom, 38)
            textField
                .padding(.bottom, 40)
        }
        .padding(.horizontal, 40)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(Color.mainViewBlockGray)
        }
    }
    
    private var timerBlock: some View {
        VStack(spacing: 0) {
            timerIcon
                .padding(.top, 26)
                .padding(.bottom, 21)
            timerComment
                .padding(.bottom, 26)
            timePicker
                .frame(height: 182)
                .padding(.bottom, 33)
        }
        .padding(.horizontal, 163)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(Color.mainViewBlockGray)
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var startButton: some View {
        Button {
            checkMeeting()
        } label: {
            Text("새 회의 시작하기")
                .font(.pretendSemibold16)
                .foregroundStyle(isValid ? .white : .buttonTextDisabled)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(isValid ? Color.pointBlue : Color.buttonDisabled )
                        
                }
            
        }
        .ignoresSafeArea(.keyboard)
        .disabled(isNotValid)
        .padding(.bottom, 70)
    }
}

// MARK: Topic Block Cells
extension NewMeetingSetupView {
    private var topicIcon: some View {
        Image(systemName: "list.bullet")
            .foregroundStyle(Color.pointBlue)
            .font(.system(size: 26))
    }
    
    private var topicComment: some View {
        Text("이번 회의 안건을 알려주세요")
            .font(.pretendSemibold24)
            .foregroundStyle(.white)
    }
    
    private var textField: some View {
        TextField("최대 20자까지 작성 가능", text: $topic)
            .font(.pretendRegular18)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($isFocused)
            .onSubmit {
                isFocused = false
            }
            .onChange(of: topic) { text in
                if text.count > 20 {
                    topic = String(text.prefix(20))
                }
            }
            .padding(EdgeInsets(top: 10, leading: 13, bottom: 9, trailing: 0))
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.sheetBlockBackgroundGray)
            }
            
    }
}

// MARK: Time Picker Cells
extension NewMeetingSetupView {
    private var timerIcon: some View {
        Image(systemName: "clock")
            .foregroundStyle(Color.pointBlue)
            .font(.system(size: 26))
    }
    
    private var timerComment: some View {
        Text("예상 회의 시간을 알려주세요")
            .font(.pretendSemibold24)
            .foregroundStyle(.white)
    }
    
    private var timePicker: some View {
        HStack(spacing: 30) {
            TimePickerView(title: "시간", range: meetingManager.timer.hoursRange, binding: $meetingManager.timer.selectedHoursAmount)
            TimePickerView(title: "분", range: meetingManager.timer.minutesRange, binding: $meetingManager.timer.selectedMinutesAmount)
            TimePickerView(title: "초", range: meetingManager.timer.secondsRange, binding: $meetingManager.timer.selectedSecondsAmount)
        }
        .foregroundStyle(.white)
    }
}

// MARK: Button Logics
extension NewMeetingSetupView {
    private func checkMeeting() {
        isChecked = true
    }
    
    private var isNotValid: Bool {
        !isValid
    }
    
    private var isValid: Bool {
        meetingManager.timer.startTime != 0 && topic.isNotEmpty
    }
}




struct NewMeetingSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NewMeetingSetupView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(MeetingManager(timer: TimerManager()))
    }
}
