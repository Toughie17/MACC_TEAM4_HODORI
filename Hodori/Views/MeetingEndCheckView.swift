//
//  MeetingEndCheckView.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

struct MeetingEndCheckView: View {
    @State private var isFinished = false
    @State private var isExtended = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            headLine
                .padding(.bottom, 70)
            topic
                .padding(.bottom, 23)
            timeSpend
                .padding(.bottom, 70)
            
            HStack(spacing: 18) {
                extendButton
                finishButton
            }
            .padding(.bottom, 25)
        }
        .padding(.horizontal, 25)
        .ignoresSafeArea()
        .interactiveDismissDisabled()
        .sheet(isPresented: $isFinished, onDismiss: {
            dismiss()
        }, content: {
            AfterMeetingView()
        })
        .sheet(isPresented: $isExtended, onDismiss: {
            dismiss()
        } ,content: {
            ExtendMeetingView()
        })
    }
    
    private var headLine: some View {
        VStack(spacing: 0) {
            Image(systemName: "exclamationmark.triangle")
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
            Text("회의가 끝나셨나요?")
                .font(.system(size: 30.25))
                .fontWeight(.semibold)
        }
    }
    
    private var topic: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill()
            .frame(maxWidth: .infinity)
            .aspectRatio(4.22, contentMode: .fit)
            .overlay(alignment: .top) {
                VStack(spacing: 0) {
                    Text("회의 안건")
                        .padding(.top, 36)
                        .padding(.bottom, 24)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                        .font(.system(size: 17))
                    Text("토끼와 고양이: 누가 더 귀여운가")
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                }
            }
    }
    
    private var timeSpend: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(Color.dargray)
            .frame(maxWidth: .infinity)
            .aspectRatio(4.22, contentMode: .fit)
            .overlay {
                HStack(spacing: 84) {
                    VStack(spacing: 0) {
                        Text("총 소요시간")
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                            .font(.system(size: 17))
                            .padding(.bottom, 11)
                        
                        Text("02:30:00")
                            .fontWeight(.light)
                            .font(.system(size: 36))
                    }
                    
                    VStack(spacing: 0) {
                        Text("총 소요시간")
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                            .font(.system(size: 17))
                            .padding(.bottom, 11)
                        
                        Text("+00:15:00")
                            .foregroundStyle(.red)
                            .fontWeight(.light)
                            .font(.system(size: 36))
                    }
                }
            }
    }
    
    private var extendButton: some View {
        Button {
            isExtended = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.blue, lineWidth: 1)
                .frame(maxWidth: .infinity)
                .aspectRatio(6.36, contentMode: .fit)
                .overlay {
                    Text("회의 연장하기")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
        }
    }
    
    private var finishButton: some View {
        Button {
            isFinished = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .frame(maxWidth: .infinity)
                .aspectRatio(6.36, contentMode: .fit)
                .overlay {
                    Text("회의 종료하기")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
        }
    }
}

struct MeetingEndCheckView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingEndCheckView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
