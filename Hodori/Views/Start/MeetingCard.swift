//
//  MeetingCard.swift
//  Hodori
//
//  Created by 송지혁 on 11/13/23.
//

import SwiftUI

struct MeetingCard: View {
    let meeting: Meeting
    @State private var textHeight: CGFloat = 0
    
    private var isMeetingExist: Bool {
        guard let firstAgenda = meeting.agendas.first else { return false }
        return firstAgenda.title.isNotEmpty
    }
    
    private var startDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        let date = meeting.startDate
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    var body: some View {
        if isMeetingExist {
            meetingCard
        } else {
            placeholder
        }
    }
    
    private var meetingCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 8) {
                PieChartView(agendas: Array(meeting.agendas))
                    .frame(width: 20, height: 20)
                
                HStack(alignment: .bottom, spacing: 8) {
                    Text("이전 회의")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.black)
                        .background { GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    textHeight = proxy.size.height
                                }
                        }}
                    Text(startDate)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(meeting.agendas, id: \.self) { agenda in
                    HStack(spacing: 16) {
                        Image(systemName: agenda.isComplete ? "checkmark" : "circle")
                            .foregroundStyle(agenda.isComplete ? .blue : .gray)
                        
                        Text(agenda.title)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundStyle(agenda.isComplete ? .gray : .black)
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray)
                .opacity(0.2)
        }
    }
    
    private var placeholder: some View {
        Text("이전 회의 내역이 아직 없어요\n새 회의를 시작해보세요")
            .font(.system(size: 16))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray)
                    .opacity(0.2)
            }
            .multilineTextAlignment(.center)
    }
}


struct PieChartView: View {
    
    let agendas: [Agenda]

    var degreePerAgenda: Double {
        Double(360 / (agendas.count))
    }
    
    var doneCount: Double {
        Double(agendas.filter { $0.isComplete == true }.count)
    }
    
    var startPercent: CGFloat = 0.1
    
    var endPercent: CGFloat  {
        CGFloat(degreePerAgenda * doneCount) - 0.01
    }
    
    var backgroundColor: Color = .blue
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .center) {
                Circle()
                    .foregroundColor(.clear)
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                
                Path { path in
                    let size = geometryProxy.size
                    let center = CGPoint(x: size.width / 2.0,
                                         y: size.height / 2.0)
                    let radius = min(size.width, size.height) / 2.0
                    path.move(to: center)
                    path.addArc(center: center,
                                radius: radius,
                                startAngle: .init(degrees: Double(self.startPercent)),
                                endAngle: .init(degrees: Double(self.endPercent)),
                                clockwise: false)
                }
                .rotation(.init(degrees: 270))
                .foregroundColor(self.backgroundColor)
                .frame(width: geometryProxy.size.width,
                       height: geometryProxy.size.height,
                       alignment: .center)
            }
        }
    }
}
