//
//  MeetingEndCheckView.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct MeetingEndCheckView: View {
    //MARK: 타이머뷰의 잔여 시간에 따라 하단 버튼의 종류를 변경해주기 위한 변수입니다.
    
    // 회의 조기 종료
    // 회의 정상 종료 (remainingTime이 0일 때 -> ExpectedTime을 보여준다.)
    @Binding var remainingTime: Int
    @Binding var firstSheetOpen: Bool
    
    @State private var isFinished = false
    @State private var isExtended = false
    
    @EnvironmentObject var meetingManager: MeetingManager
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sheetBackgroundGray.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headLineBlock
                        .padding(.top, 48)
                        .padding(.bottom, 70)
                    
                    topicTimeBlock
                        .padding(.bottom, 81)
                    
                    buttonBlock
                        .padding(.bottom, 40)
                    
                }
                .padding(.horizontal, 40)
                .interactiveDismissDisabled()
                
    //            .sheet(isPresented: $isFinished, content: {
    //                AfterMeetingView()
    //            })
                .sheet(isPresented: $isFinished, onDismiss: {
                    dismiss()
                }, content: {
                    AfterMeetingView(firstSheetOpen:$firstSheetOpen)
                })
    //            .sheet(isPresented: $isExtended, content: {
    //                ExtendMeetingView()
    //            })
                .sheet(isPresented: $isExtended, onDismiss: {
                    dismiss()
                } ,content: {
                    ExtendMeetingView(firstSheetOpen: $firstSheetOpen)
                })
            }
        }
        .navigationBarHidden(true)
    }
}


extension MeetingEndCheckView {
    
    private var headLineBlock: some View {
        VStack(spacing: 0) {
            Image(systemName: "exclamationmark.triangle")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 36))
                .frame(width: 45, height: 43)
                .padding(.bottom, 26)
                .foregroundColor(Color.sheetIconBlue)
            
            Text("회의 종료!")
                .font(.pretendMedium20)
                .padding(.bottom, 16)
                .foregroundColor(.sheetFontLightGray)
            
            Text("회의가 끝나셨나요?")
                .font(.pretendSemibold30)
                .foregroundColor(.sheetFontWhite)
        }
    }
    
    private var topicTimeBlock: some View {
        VStack(spacing: 24) {
            topicCell
            timeCell
        }
    }
    
    private var topicCell: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.sheetCellBackgroundGray)
            .frame(width: .infinity)
            .frame(height: 155)
            .overlay(alignment: .top) {
                VStack(spacing: 0) {
                    Text("회의 안건")
                        .font(.pretendMedium16)
                        .foregroundColor(.sheetFontLightGray)
                        .padding(.top, 30)
                    
                    Text(meetingManager.meeting?.topic ?? "토끼와 고양이: 누가 더 귀여운가")
                        .font(.pretendMedium24)
                        .foregroundColor(.white)
                        .padding(.top, 24)
                }
            }
    }
    
    private var timeCell: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.sheetCellBackgroundGray)
            .frame(width: .infinity)
            .frame(height: 155)
            .overlay {
                HStack(spacing: 72.8) {
                    VStack(spacing: 20) {
                        Text("총 소요시간")
                            .font(.pretendMedium16)
                            .foregroundColor(.sheetFontLightGray)
                        
                        Text(
                            ((meetingManager.meeting?.expectedTime ?? 0) - (remainingTime)).asTimestamp
                        )
                        .font(.system(size: 36, weight: .light))
                        .foregroundColor(.white)
                        
                    }
                    
                    // MARK: 타이머에서 추가되는 시간 로직에 따라 수정 필요
                    if meetingManager.meeting?.addedTime ?? 0 > 0 {
                        VStack(spacing: 20) {
                            Text("추가한 시간")
                                .font(.pretendMedium16)
                                .foregroundColor(.sheetFontLightGray)
                            
                            Text("02:30:00")
                                .font(.system(size: 36, weight: .light))
                                .foregroundColor(.sheetSmallTimerPink)
                        }
                    }
                }
            }
    }

    private var buttonBlock: some View {
        HStack(spacing: 21) {
//            Group {
                if remainingTime > 0 {
                    Button {
//                        dismiss()
                        // MARK: 타이머 재작동 함수 실행
                        
                    } label: {
                        makeButtonLabel(text: "회의 이어서 진행하기", isStroked: true)
                    }
                }
                else {
//                    Button {
//                        isExtended = true
//                    } label: {
//                        makeButtonLabel(text: "회의 연장하기", isStroked: true)
//                    }
                    
                    NavigationLink(destination: ExtendMeetingView(firstSheetOpen: $firstSheetOpen)) {
                        makeButtonLabel(text: "회의 연장하기", isStroked: true)
                    }
                }
//            }
            
            Button {
                isFinished = true
               
            } label: {
                makeButtonLabel(text: "회의 종료하기", isStroked: false)
            }
        }
    }
    
    
    private func makeButtonLabel(text: String, isStroked: Bool) -> some View {
        Group {
            if isStroked {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.sheetIconBlue, lineWidth: 2)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.sheetIconBlue)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height:50)
        .overlay {
            Text(text)
                .font(.pretendSemibold16)
                .foregroundStyle(.white)
        }
    }
}

//struct MeetingEndCheckView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetingEndCheckView(remainingTime: .constant(10))
//            .environmentObject(MeetingManager(timer: TimerManager()))
//            .preferredColorScheme(.light)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}

struct MeetingEndCheckView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTestDummy()
            .environmentObject(MeetingManager(timer: TimerManager()))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}



