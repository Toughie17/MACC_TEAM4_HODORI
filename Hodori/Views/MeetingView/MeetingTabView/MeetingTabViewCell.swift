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
    
    let needLeftLine: Bool
    let needRightLine: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white)
            
            VStack(alignment: .leading, spacing: 0) {
                
                checkLine
                    .padding(.top, 46)
                    .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    agendaOrderText
                        .padding(.bottom, 4)
                    currentAgendaTitle
                        .padding(.bottom, 28)
                        .padding(.trailing, 80)
                    agendaDetails
                    Spacer()
                }
                .padding(.leading, 36)
            }
            .padding(.top, 28)
            
            if showLottie {
                MeetingLottieView(index: index)
            }
        }
    }
}

extension MeetingTabViewCell {
    
    private var checkLine: some View {
        HStack(spacing: 0) {
            
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 2)
                .frame(width: 24)
                .foregroundStyle(needLeftLine ? Color.gray9 : Color.clear)
                .padding(.trailing, 12)
            
            Image(systemName: agenda.isComplete ? "checkmark.circle.fill" : "circle")
                .fontWeight(.heavy)
                .frame(width: 22, height: 22)
                .foregroundStyle(Color.primaryBlue)
                .padding(.trailing, 12)
            
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundStyle(needRightLine ? Color.gray9 : Color.clear)
        }
    }
    
    private var agendaOrderText: some View {
        Text(agendaTitle(forIndex: index))
            .font(.pretendMedium20)
            .foregroundStyle(agenda.isComplete ? Color.gray6 : Color.gray5)
            .foregroundStyle(Color.gray5)
    }
    
    private var currentAgendaTitle: some View {
        Text(agenda.title)
            .font(.pretendBold24)
            .foregroundStyle(agenda.isComplete ? Color.gray3 : Color.black)
    }
    
    private var agendaDetails: some View {
        Group {
            if agenda.detail != [""] {
                ForEach(agenda.detail, id: \.self) { detail in
                    HStack(spacing: 0) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 3, height: 3)
                            .padding(.trailing, 8)
                        
                        Text(detail)
                            .font(.pretendRegular16)
                            .lineLimit(1)
                    }
                    .foregroundStyle(agenda.isComplete ? Color.gray7 : Color.gray2)
                    .padding(.bottom, 8)
                }
            } else {
                EmptyView()
            }
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
    ZStack {
        Color.black.ignoresSafeArea()
        MeetingTabViewCell(agenda: Agenda(title: "토끼는 설치류인가 아님 만약 안건이 두줄", detail: ["하이하이하이하이하이하이하이하이하이", "헤이", "호"], isComplete: false), index: 0, showLottie: .constant(false), needLeftLine: true, needRightLine: true)
    }
}
