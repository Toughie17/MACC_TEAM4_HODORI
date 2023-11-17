//
//  MeetingCard.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import SwiftUI

enum CardState {
    case last
    case history
}

struct MeetingCard: View {
    let cardState: CardState
    let meeting: Meeting
    
    private var fullDate: String {
        return dateFormat(meeting.startDate, format: "yyyy년 MM월 dd일 HH:mm")
    }
    
    private var year: String {
        return dateFormat(meeting.startDate, format: "yyyy년")
    }
    
    private var dayMonth: String {
        return dateFormat(meeting.startDate, format: "M월 d일")
    }
    
    private var time: String {
        return dateFormat(meeting.startDate, format: "HH:mm")
    }
    
    init(_ cardState: CardState, meeting: Meeting) {
        self.cardState = cardState
        self.meeting = meeting
        
    }
    
    private func dateFormat(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = date
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 31) {
            header
            agendas
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 24)
        .padding(.top, 26)
        .padding(.bottom, 29)
        .padding(.trailing, 28)
        .cardBackground(opacity: cardState == .last ? 0.1 : 0.05, radius: cardState == .last ? 20 : 40, y: 4)
    }
    
    private var header: some View {
        HStack(spacing: 12) {
            PieChartView(agendas: Array(meeting.agendas))
                .frame(width: 24, height: 24)
            
            HStack(alignment: .bottom, spacing: 8) {
                Text(cardState == .last ? "이전 회의" : dayMonth)
                    .font(.pretendBold20)
                    .foregroundStyle(.black)
                
                Text(cardState == .last ? fullDate : time)
                    .font(.pretendRegular14)
                    .foregroundStyle(Color.gray6)
            }
            
            Spacer()
            
            if cardState == .history {
                NavigationLink {
                    HistoryDetailView(meeting: meeting)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    private var agendas: some View {
        VStack(spacing: 2) {
            ForEach(Array(zip(meeting.agendas.indices, meeting.agendas)), id: \.0) { index, agenda in
                AgendaCell(state: .normal, agenda: agenda, index: index, meeting: meeting, titleFont: .pretendMedium16)
            }
        }
    }
}
