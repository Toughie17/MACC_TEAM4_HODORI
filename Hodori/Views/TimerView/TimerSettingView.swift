//
//  TimerSettingView.swift
//  Hodori
//
//  Created by Yujin Son on 2023/11/14.
//

import SwiftUI

struct TimerSettingView: View {
    
    @Environment(\.presentationMode) var presentation
    @State private var countSec = 0.0
    @Binding var sec : Double
    @Binding var showModal : Bool
    @Binding var showTimer : Bool
    
    private let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)
    
    var hourIndex: Int {
        return Int(sec / 3600)
    }
    
    var minIndex: Int {
        return Int(sec / 60)
    }
    
    
    var body: some View {
        NavigationView{
            VStack (spacing: 0) {
                HStack {
                    Spacer()
                    VStack {
                        headLineText
                    }
                    cancelButton
                }
                CustomPicker(sec: $sec)
                    .frame(width: 220)
                    .padding(.top,20)
                
                timerStartButton
                    .padding(.top, 30)
                
            }
        }
    }
    
    private var headLineText: some View {
        Text("타이머 설정하기")
            .foregroundColor(.gray2)
            .font(.pretendBold20)
            .multilineTextAlignment(.center)
            .padding(.top, 49)
    }
    
    private var cancelButton: some View {
        Button(action: {
            mediumHaptic.impactOccurred()
            self.presentation.wrappedValue.dismiss()
            sec = 0.0
            
        }) {
            Image(systemName:"xmark")
                .foregroundColor(.gray3)
                .font(.system(size: 24, weight: .regular))
                .padding(.top, 50)
                .padding(.leading, 79)
                .padding(.trailing, 16)
        }
    }
    
    private var timerStartButton: some View {
        Button {
            mediumHaptic.impactOccurred()
            withAnimation(.bouncy){
                showModal.toggle()
                showTimer.toggle()
            }
        } label:{
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill((hourIndex == 0 && minIndex == 0 ) ? Color.gray5 : Color.gray1)
                    .frame(width: 342, height: 54)
                Text("타이머 시작")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .disabled(hourIndex == 0 && minIndex == 0 )
        .padding(.horizontal, 20)
    }
}

#Preview {
    TimerSettingView(sec : Binding.constant(0), showModal: Binding.constant(false),showTimer: Binding.constant(false))
}
