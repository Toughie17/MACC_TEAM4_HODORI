//
//  MeetingAlert.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct MeetingAlert: View {
    @Binding var showAlert: Bool
    @Binding var toMeetingEndView: Bool
    //MARK: 미팅뷰에서 계산을 하거나, 미팅 매니저에서 카운트 값을 가지고 있으면 좋을듯
    let leftAgenda: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
            
            VStack(spacing: 0) {
                triangleImage
                    .padding(.top, 28)
                    .padding(.bottom, 16)
                textBox
                    .padding(.bottom, 42)
                Divider()
                buttonBox
            }
        }
        .frame(width: 325, height: 247)
    }
}

extension MeetingAlert {
    
    private var triangleImage: some View {
        Image(systemName: "exclamationmark.triangle")
            .fontWeight(.bold)
            .font(.system(size: 32))
            .foregroundColor(.pink)
    }
    
    private var textBox: some View {
        VStack(spacing: 0) {
            Text("종료하시겠어요?")
                .fontWeight(.bold)
                .padding(.bottom, 8)
            if leftAgenda == 0 {
                Text("설정한 모든 안건을 완료했어요!")
            } else {
                Text("아직 안 끝낸 \(leftAgenda)개의 안건이 있어요")
            }
        }
    }
    
    private var buttonBox: some View {
        HStack {
            Spacer()
            cancelButton
            Divider()
            endButton
            Spacer()
        }
    }
    
    private var cancelButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay (
                VStack {
                    Spacer()
                    Text("취소")
                    
                    Spacer()
                }
            )
            .onTapGesture {
                showAlert = false
            }
    }
    
    private var endButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay (
                VStack {
                    Spacer()
                    Text("종료하기")
                        .foregroundColor(.blue)
                    Spacer()
                }
            )
            .onTapGesture {
                showAlert = false
                toMeetingEndView = true
            }
    }
}

//#Preview {
//    MeetingAlert(showAlert: .constant(true), leftAgenda: 0)
//}

