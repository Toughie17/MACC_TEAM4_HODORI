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
    
    var hourIndex: Int {
        return Int(sec / 3600)
        }

    var minIndex: Int {
        return Int(sec / 60)
        }
   
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("타이머 설정하기")
                        .foregroundColor(.black)
                        .padding(.top, 27)
                        .padding(.leading, 140)
                        .padding(.trailing, 94)
                    
                    
                    // 모달 닫기 버튼
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName:"xmark")
                            .foregroundColor(.black)
                            .imageScale(.medium)
                            .padding(.top, 23)
                            .padding(.trailing, 19)
                    }
                    
                }
                CustomPicker(sec: $sec)
                
                
                //                 타이머 시작 버튼
                //                Button{TimerRunningView(sec: $sec)}label: {
                //
                //
                //                    ZStack {
                //                        RoundedRectangle(cornerRadius: 16)
                //                            .fill(.blue)
                //                            .frame(width: 353, height: 56)
                //                        Text("시작")
                //                            .foregroundColor(.white)
                ////                            .opacity( ? 1: 0.4)
                //
                //                    }
                //
                
                Button{
                    withAnimation(.bouncy){
                        showModal.toggle()
                        showTimer.toggle()
                    }
                } label:{
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill((hourIndex == 0 && minIndex == 0 ) ? .gray : .blue)
                            .frame(width: 353, height: 56)
                        Text("시작")
                        .foregroundColor(.white)                }
                    .padding(.horizontal, 20)
                    
                }
                .disabled(hourIndex == 0 && minIndex == 0 )
                .padding(.horizontal, 20)
                
            }
        }
    }
}

#Preview {
    TimerSettingView(sec : Binding.constant(0), showModal: Binding.constant(false),showTimer: Binding.constant(false))
}
