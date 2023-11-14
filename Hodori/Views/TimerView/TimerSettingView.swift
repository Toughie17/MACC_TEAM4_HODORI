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
    @State var sec : Double = 0.0
    
    
    
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
                
                
                // 타이머 시작 버튼
                NavigationLink{TimerView(sec: $sec)}label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                            .frame(width: 353, height: 56)
                        Text("시작")
                            .foregroundColor(.white)
//                            .opacity( ? 1: 0.4)
                    }
                    
//                    .disabled(! !review.isEmpty))
                    
                }
                .padding(.horizontal, 20)
                
            }
            
        }
    }
}

struct TimepickerTest_Previews: PreviewProvider {
    static var previews: some View {
        TimerSettingView()
    }
}
