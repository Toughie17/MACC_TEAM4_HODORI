//
//  Meeting.swift
//  Hodori
//
//  Created by Eric on 10/15/23.
//

import Foundation

// 객체 생성 시점은 회의릘 시작할게요 버튼 눌렀을 때.
struct Meeting: Identifiable, Hashable {
    // MARK: 회의를 시작할게요 버튼 누를 때 넣어줄 데이터
    var topic: String
    var expectedTime: Int
    let date: Date = Date()
    
    // MARK: EndCheck, Extend에서 업데이트 해주는 데이터
    // expectedTime을 넘어가는 시간
    var addedTime: Int = 0
    // expectedTime보다 일찍 회의를 종료했을 경우 그 시간 차
    var earlyEndingTime: Int = 0
    
    // MARK: After Meeting 에서 채워주는 데이터
    var satisfaction: String = ""
    var review: String = ""
    var keywords: [String] = []
    
    var id = UUID().uuidString
}
