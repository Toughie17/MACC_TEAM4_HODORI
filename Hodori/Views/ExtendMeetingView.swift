//
//  ExtendMeetingView.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct ExtendMeetingView: View {
    @State private var time: Int = 0
    @EnvironmentObject var meetingManager: MeetingManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            headLine
                .padding(.bottom, 82)
            
            HStack(spacing: 14) {
                fiveTimeAddButton
                tenTimeAddButton
                resetButton
            }
            .foregroundStyle(.white)
            .padding(.bottom, 24)
            
            timeStepper
                .padding(.bottom, 60)
            
            warningText
                .padding(.bottom, 35)
            
            HStack(spacing: 18) {
                extendButton
                finishButton
            }
            .padding(.bottom, 25)
            
        }
        .ignoresSafeArea()
        .interactiveDismissDisabled()
        .padding(.horizontal, 25)
    }
    
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(time*60))!
    }
    
    private var headLine: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus.circle")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 36))
                .padding(.top, 40)
                .padding(.bottom, 29)
                .foregroundStyle(.blue)
            Text("회의 종료!")
                .font(.system(size: 20.16))
                .fontWeight(.medium)
                .padding(.bottom, 11)
                .foregroundStyle(.gray)
            Text("회의 시간을 추가할까요?")
                .font(.system(size: 30.25))
                .fontWeight(.semibold)
        }
    }
    
    private var fiveTimeAddButton: some View {
        Button {
            time += 5
        } label: {
            Text("+5분")
                .padding(.vertical, 5)
                .padding(.horizontal, 14)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                }
                .font(.system(size: 20))
        }
    }
    
    private var tenTimeAddButton: some View {
        Button {
            time += 10
        } label: {
            Text("+10분")
                .padding(.vertical, 5)
                .padding(.horizontal, 14)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                }
                .font(.system(size: 20))
        }
    }
    
    private var resetButton: some View {
        Button {
            time = 0
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 20))
                .padding(.top, 5.54)
                .padding(.bottom, 5.46)
                .padding(.horizontal, 7)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                }
        }
        
        
    }
    
    private var timeStepper: some View {
        RoundedRectangle(cornerRadius: 14)
            .frame(maxWidth: .infinity)
            .aspectRatio(3, contentMode: .fit)
            .overlay {
                VStack(spacing: 28) {
                    Text("추가된 시간")
                        .fontWeight(.medium)
                        .font(.system(size: 17))
                        .foregroundStyle(.gray)
                        .padding(.top, 43)
                    
                    Text("+ \(formattedTime)")
                        .fontWeight(.light)
                        .font(.system(size: 48))
                        .padding(.bottom, 69)
            }
            }
    }
    
    private var warningText: some View {
        Text("시간 추가는 한 번밖에 못해")
            .fontWeight(.medium)
            .font(.system(size: 17))
            .foregroundStyle(.red)
    }
    
    private var extendButton: some View {
        Button {
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.blue, lineWidth: 1)
                .frame(maxWidth: .infinity)
                .aspectRatio(6.36, contentMode: .fit)
                .overlay {
                    Text("그만 마칠래요")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
        }
    }
    
    private var finishButton: some View {
        Button {
            dismiss()
            meetingManager.timer.addTime(time)
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .frame(maxWidth: .infinity)
                .aspectRatio(6.36, contentMode: .fit)
                .overlay {
                    Text("회의 이어가기")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
        }
    }
}

struct ExtendMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendMeetingView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
