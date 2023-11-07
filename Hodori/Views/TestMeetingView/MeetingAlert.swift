//
//  MeetingAlert.swift
//  Hodori
//
//  Created by Toughie on 11/7/23.
//

import SwiftUI

struct MeetingAlert: View {
    @Binding var showAlert: Bool
    let leftAgenda: Int = 3
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
            
            VStack(spacing: 0) {
                Image(systemName: "exclamationmark.triangle")
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
                    .padding(.top, 25)
                    .padding(.bottom, 21)
                
                Text("아직 안 끝낸 \(leftAgenda)개의 안건이 있어요")
                    .padding(.bottom, 6)
                Text("진짜 종료하시겠어요?")
                    .fontWeight(.bold)
                    .padding(.bottom, 38)
                
                Divider()
                
                HStack {
                    Spacer()
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
                    
                    Divider()
                    
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
                        }
                    Spacer()
                }
            }
        }
        .frame(width: 325, height: 247)
    }
}

#Preview {
    MeetingAlert(showAlert: .constant(true))
}

