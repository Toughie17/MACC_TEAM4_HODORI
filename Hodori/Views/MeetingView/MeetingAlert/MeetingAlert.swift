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
    let leftAgenda: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
            
            VStack(spacing: 0) {
                
                textBox
                    .padding(.top, 32)
                    .padding(.bottom, 28)
                Divider()
                buttonBox
            }
        }
        .frame(width: 282, height: 172)
    }
}

extension MeetingAlert {
    
    private var textBox: some View {
        VStack(spacing: 0) {
            Text("종료하시겠어요?")
                .font(.pretendBold20)
                .foregroundStyle(.black)
                .padding(.bottom, 12)
            
            Text(leftAgenda == 0 ? "설정한 모든 안건을 완료했어요!" : "아직 끝내지 못한 안건이 \(leftAgenda)개 있어요" )
                .font(.pretendRegular16)
                .foregroundStyle(Color.gray4)
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
                        .font(.pretendMedium16)
                        .foregroundStyle(Color.gray3)
                    
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
                        .font(.pretendMedium16)
                        .foregroundStyle(Color.primaryBlue)
                    Spacer()
                }
            )
            .onTapGesture {
                showAlert = false
                toMeetingEndView = true
            }
    }
}

#Preview {
    ZStack {
        Color.black
        MeetingAlert(showAlert: .constant(true), toMeetingEndView: .constant(false), leftAgenda: 3)
    }
}
