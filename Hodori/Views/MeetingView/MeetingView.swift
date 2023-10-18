//
//  MeetingView.swift
//  Hodori
//
//  Created by Eric on 10/17/23.
//

import AVFAudio
import SwiftUI

struct MeetingView: View {
    @EnvironmentObject var meetingManager: MeetingManager
    @State private var firstSheetOpen = false
    @State private var audioPlayer: AVAudioPlayer?
    
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
            switch state {
            case .cancelled:
                firstSheetOpen = true
            default:
                break
            }
        }
        .sheet(isPresented: $firstSheetOpen) {
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

// MARK: Sound Logic
extension MeetingView {
    private func playSound() {
        guard let soundPath = Bundle.main.path(forResource: "", ofType: "") else { return }
        let url = URL(filePath: soundPath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    private func stopSound() {
        audioPlayer?.stop()
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
