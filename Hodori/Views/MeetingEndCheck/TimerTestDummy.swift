//
//  TimerTestDummy.swift
//  Hodori
//
//  Created by Toughie on 2023/10/17.
//

import SwiftUI

struct TimerTestDummy: View {
    @EnvironmentObject var meetingModel: MeetingManager
    @State var remainingTime: Int = 0
    
    @State private var stopButtonTapped: Bool = false
//    @State private var isNotFinished: Bool =  false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("남은시간: \(remainingTime)")
                    .font(.pretendSemibold64)
                    .foregroundColor(.white)
                
                Button {
                    stopButtonTapped.toggle()
                } label: {
                    Text("회의 정지 버튼")
                        .foregroundColor(.blue)
                        .font(.pretendSemibold64)
                }

            }
            .sheet(isPresented: $stopButtonTapped) {
                MeetingEndCheckView(remainingTime: $remainingTime)
        }
        }
    }
    
}

struct TimerTestDummy_Previews: PreviewProvider {
    static var previews: some View {
        TimerTestDummy()
            .environmentObject(MeetingManager(timer: TimerManager()))
            .previewInterfaceOrientation(.landscapeLeft)
//            .preferredColorScheme(.dark)
    }
}
