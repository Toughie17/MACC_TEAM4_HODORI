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
    
    @State private var firstSheetOpen: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("남은시간: \(remainingTime.asTimestamp)")
                    .font(.pretendSemibold64)
                    .foregroundColor(.white)
                
                Button {
                    firstSheetOpen.toggle()
                } label: {
                    Text("회의 정지 버튼")
                        .foregroundColor(.blue)
                        .font(.pretendSemibold64)
                }

            }
            .sheet(isPresented: $firstSheetOpen) {
                MeetingEndCheckView(remainingTime: $remainingTime, firstSheetOpen: $firstSheetOpen)
        }
        }
//        .onAppear {
//            remainingTime = meetingModel.meeting?.expectedTime ?? 0
//        }
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
