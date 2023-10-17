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
    // MARK: 남은 시간이 0이 되거나, 정지 버튼을 눌렀을 때 true
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
    }
}

struct TimerTestDummy_Previews: PreviewProvider {
    static var previews: some View {
        TimerTestDummy()
            .environmentObject(MeetingManager(timer: TimerManager()))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
