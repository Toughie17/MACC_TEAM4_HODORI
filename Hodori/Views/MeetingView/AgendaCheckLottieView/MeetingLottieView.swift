//
//  MeetingLottieView.swift
//  Hodori
//
//  Created by Toughie on 11/9/23.
//

import SwiftUI

struct MeetingLottieView: View {
    let backColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593991637, alpha: 1)
    let index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.gray10)
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                LottieView(jsonName: "CheckLottie", loopMode: .loop)
                    .frame(width: 67, height: 67)
                    .padding(.bottom, 32)
                Text(agendaEndTitle(forIndex: index))
                    .foregroundStyle(Color.gray2)
                    .font(.pretendRegular20)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

extension MeetingLottieView {
    private func agendaEndTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫번째 안건을 끝냈어요!"
        case 1:
            return "두번째 안건을 끝냈어요!"
        case 2:
            return "세번째 안건을 끝냈어요!"
        case 3:
            return "네번째 안건을 끝냈어요!"
        case 4:
            return "다섯번째 안건을 끝냈어요!"
        case 5:
            return "여섯번째 안건을 끝냈어요!"
        case 6:
            return "일곱번째 안건을 끝냈어요!"
        case 7:
            return "여덟번째 안건을 끝냈어요!"
        case 8:
            return "아홉번째 안건을 끝냈어요!"
        case 9:
            return "열번째 안건을 끝냈어요!"
        default:
            return "X번째 안건을 끝냈어요!"
        }
    }
}

                
                
                
#Preview {
    MeetingLottieView(index: 3)
}
