//
//  MeetingLottieView.swift
//  Hodori
//
//  Created by Toughie on 11/9/23.
//

import SwiftUI

struct MeetingLottieView: View {
    let index: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white)
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                LottieView(jsonName: "loadingLottieV3", loopMode: .loop)
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 16)
                Text(agendaEndTitle(forIndex: index))
                    .foregroundStyle(Color.gray2)
                    .font(.pretendRegular20)
                Spacer()
            }
        }
    }
}

extension MeetingLottieView {
    private func agendaEndTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫 번째 안건을 끝냈어요!"
        case 1:
            return "두 번째 안건을 끝냈어요!"
        case 2:
            return "세 번째 안건을 끝냈어요!"
        case 3:
            return "네 번째 안건을 끝냈어요!"
        case 4:
            return "다섯 번째 안건을 끝냈어요!"
        case 5:
            return "여섯 번째 안건을 끝냈어요!"
        case 6:
            return "일곱 번째 안건을 끝냈어요!"
        case 7:
            return "여덟 번째 안건을 끝냈어요!"
        case 8:
            return "아홉 번째 안건을 끝냈어요!"
        case 9:
            return "열 번째 안건을 끝냈어요!"
        default:
            return "X 번째 안건을 끝냈어요!"
        }
    }
}

#Preview {
    MeetingLottieView(index: 3)
}
