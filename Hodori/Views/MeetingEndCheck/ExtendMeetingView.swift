//
//  ExtendMeetingView.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct ExtendMeetingView: View {
    @State private var extendTime: Int = 0
    @Binding var firstSheetOpen: Bool
    
    var body: some View {
        
        ZStack {
            Color.sheetBackgroundGray.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headLineBlock
                    .padding(.top, 48)
                    .padding(.bottom, 80)
                addTimeBlock
                    .padding(.bottom, 26)
                showTimeBlock
                    .padding(.bottom, 113)
                buttonBlock
                    .padding(.bottom, 40)
            }
            .interactiveDismissDisabled()
            .padding(.horizontal, 40)
        }
        .navigationBarHidden(true)
    }
}

extension ExtendMeetingView {
    
    private var headLineBlock: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus.circle")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 36))
                .frame(width: 43, height: 43)
                .padding(.bottom, 26)
                .foregroundColor(Color.sheetIconBlue)
            
            Text("회의 종료!")
                .font(.pretendMedium20)
                .padding(.bottom, 16)
                .foregroundColor(.sheetFontLightGray)
            
            Text("회의 시간을 추가할까요?")
                .font(.pretendSemibold30)
                .foregroundColor(.sheetFontWhite)
        }
    }

    private var addTimeBlock: some View {
        HStack(spacing: 12) {
            fiveMinutesButton
            tenMinutesButton
            resetButton
        }
    }
    
    private var fiveMinutesButton: some View {
        Button {
            extendTime += 300
        } label: {
            Text("+5분")
                .font(.pretendRegular20)
                .foregroundColor(.sheetFontWhite)
                .padding(.vertical,6)
                .padding(.horizontal,15)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.sheetCellBackgroundGray)
                )
                .frame(width: 72, height: 36)
        }
    }
    
    private var tenMinutesButton: some View {
        Button {
            extendTime += 600
        } label: {
            Text("+10분")
                .font(.pretendRegular20)
                .foregroundColor(.sheetFontWhite)
                .padding(.vertical,6)
                .padding(.horizontal,15)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.sheetCellBackgroundGray)
                )
                .frame(width: 82, height: 36)
        }
    }
    
    private var resetButton: some View {
        Button {
            extendTime = 0
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
                .padding(7)
                .background {
                    Circle()
                        .fill(Color.sheetCellBackgroundGray)
                }
                .frame(width: 36, height: 36)
        }
    }
    
    private var showTimeBlock: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.sheetCellBackgroundGray)
            .frame(width: .infinity)
            .frame(height: 218)
            .overlay(alignment: .top) {
                VStack(spacing: 29) {
                    Text("추가된 시간")
                        .font(.pretendMedium16)
                        .foregroundColor(.sheetFontLightGray)
                        .padding(.top, 43)
                    
                    Text("+ \(extendTime.asTimestamp)")
                        .font(.system(size: 48, weight: .light))
                        .foregroundColor(.sheetBigTimerWhite)
                }
            }
    }
    
    private var buttonBlock: some View {
        HStack(spacing: 21) {
            NavigationLink {
                AfterMeetingView(firstSheetOpen: $firstSheetOpen)
            } label: {
                makeButtonLabel(text: "그만 마칠래요", isStroked: true)
            }
            
            Button {
                // MARK: 타이머에 시간 추가하는 코드 추가 필요
                // extendTime을 넘겨줘야함.
                firstSheetOpen = false
                
            } label: {
                makeButtonLabel(text: "회의 이어하기", isStroked: false)
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

//struct ExtendMeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExtendMeetingView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}

struct ExtendMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTestDummy()
            .environmentObject(MeetingManager(timer: TimerManager()))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
}
