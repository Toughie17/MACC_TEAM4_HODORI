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
            .font(.system(size: 32, weight: .semibold))
            .foregroundStyle(Color.subRed)
    }
    
    private var textBox: some View {
        VStack(spacing: 0) {
            Text("종료하시겠어요?")
                .font(.pretendBold20)
                .padding(.bottom, 8)
            
            Text(leftAgenda == 0 ? "설정한 모든 안건을 완료했어요!" : "아직 안 끝낸 \(leftAgenda)개의 안건이 있어요" )
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
                        .font(.pretendMedium20)
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
                        .font(.pretendMedium20)
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
    MeetingAlert(showAlert: .constant(true), toMeetingEndView: .constant(false), leftAgenda: 3)
}

