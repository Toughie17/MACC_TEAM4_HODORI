//
//  AfterMeetingView.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import SwiftUI

enum Evaluate: String, CaseIterable, Identifiable {
    case exhausting
    case average
    case efficient
    
    var description: String {
        switch self {
        case .exhausting:
            return "소모적이었어요"
        case .average:
            return "보통이었어요"
        case .efficient:
            return "효율적이었어요"
        }
    }
    
    var id: String {
        UUID().uuidString
    }
}

struct AfterMeetingView: View {
    @State private var hashtagText = ""
    @State private var reviewText = ""
    @State private var selectedEvaluation: Evaluate?
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: 추가된 코드
    @Binding var firstSheetOpen: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            headLine
                .padding(.bottom, 59)
            evaluation
                .padding(.bottom, 54)
            hashtags
                .padding(.bottom, 30)
            review
                .padding(.bottom, 96)
            finishButton
                .padding(.bottom, 30)
            
        }
        // MARK: 추가된 코드
        .navigationBarHidden(true)
        
        .ignoresSafeArea()
        .interactiveDismissDisabled()
        .padding(.horizontal, 25)
    }
    
    
    private var headLine: some View {
        VStack(spacing: 0) {
            Image(systemName: "face.smiling.inverse")
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
            Text("이번 회의 어떠셨나요?")
                .font(.system(size: 30.25))
                .fontWeight(.semibold)
        }
    }
    
    private var evaluation: some View {
        HStack(spacing: 60) {
            ForEach(Evaluate.allCases, id: \.self) { evaluate in
                EvaluationCell(isSelected: evaluate == selectedEvaluation, evaluate: evaluate)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedEvaluation = evaluate
                        }
                    }
            }
        }
    }
    
    private var hashtags: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("키워드")
                .fontWeight(.semibold)
                .font(.system(size: 15))
            TextField("#해시태그 입력 후 스페이스바를 눌러 등록해주세요", text: $hashtagText)
                .padding(10)
                .padding(.leading, 6)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                }
        }
    }
    
    private var review: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text("회의 리뷰")
                .fontWeight(.semibold)
                .font(.system(size: 15))
            TextField("오늘 회의 분위기가 어땠는지 간단히 적어주세요.", text: $reviewText)
                .padding(.top, 14)
                .padding(.leading, 16)
                .padding(.bottom, 43)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                }
        }
    }
    
    private var finishButton: some View {
        Button {
            // MARK: 추가된 코드
            firstSheetOpen = false
        } label: {
            Text("저장하고 회의 마치기")
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue)
                }
        }
        
    }
}


//struct AfterMeetingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AfterMeetingView()
//            .preferredColorScheme(.dark)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
