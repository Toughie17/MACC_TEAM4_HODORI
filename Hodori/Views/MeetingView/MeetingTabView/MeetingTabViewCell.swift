//
//  MeetingTabViewCell.swift
//  Hodori
//
//  Created by Toughie on 11/8/23.
//

import SwiftUI

struct MeetingTabViewCell: View {
    let agenda: Agenda
    let index: Int
    
    @Binding var showLottie: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.gray10)
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 10)
            
            VStack(alignment: .leading, spacing: 0) {
                agendaOrderText
                    .padding(.bottom, 12)
                currentAgendaTitle
                    .padding(.bottom, 20)
                agendaDetails
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            
            if showLottie {
                MeetingLottieView(index: index)
            }
        }
    }
}

extension MeetingTabViewCell {
    
    private var agendaOrderText: some View {
        HStack(spacing: 0) {
            
            Image(systemName: agenda.isComplete ? "checkmark.circle" : "circle")
                .fontWeight(agenda.isComplete ? .medium : .heavy)
                .frame(width: 19, height: 19)
            
            Text(agendaTitle(forIndex: index))
                .font(.pretendRegular16)
                .padding(.leading, 11.57)
            Spacer()
        }
        .foregroundStyle(agenda.isComplete ? Color.primaryBlue : Color.gray5)
    }
    
    private var currentAgendaTitle: some View {
        Text(agenda.title)
            .font(.pretendBold24)
            .foregroundStyle(agenda.isComplete ? Color.gray3 : Color.black)
    }
    
    private var agendaDetails: some View {
        ForEach(agenda.detail, id: \.self) { detail in
            HStack(spacing: 0) {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 3, height: 3)
                Text(detail)
                    .font(.pretendRegular16)
                    .padding(.leading, 8)
            }
            .foregroundStyle(agenda.isComplete ? Color.gray5 : Color.gray2)
            .padding(.bottom, 6)
        }
    }
    
    private func agendaTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "첫번째 안건"
        case 1:
            return "두번째 안건"
        case 2:
            return "세번째 안건"
        case 3:
            return "네번째 안건"
        case 4:
            return "다섯번째 안건"
        case 5:
            return "여섯번째 안건"
        case 6:
            return "일곱번째 안건"
        case 7:
            return "여덟번째 안건"
        case 8:
            return "아홉번째 안건"
        case 9:
            return "열번째 안건"
        default:
            return "알 수 없는 안건"
        }
    }
}

#Preview {
    MeetingTabViewCell(agenda: Agenda(title: "오늘의 첫번째 회의안건은 이것이 되겠네요", detail: ["세부 회의 안건", "세부 회의 안건", "세부 회의 안건", "세부 회의 안건", "세부 회의 안건은 이걸루 끝인가요 이게 마지막"], isComplete: false), index: 0, showLottie: .constant(false))
}
