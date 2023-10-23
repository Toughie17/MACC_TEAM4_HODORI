//
//  MeetingAfterView.swift
//  Hodori
//
//  Created by Yujin Son on 2023/10/20.
//

import SwiftUI


struct MeetingAfterView: View {
    
    @FocusState private var idEditing: Bool
    
    @State var review: String = ""
    @State var keyword: String = ""
    let placeholder: String = "이번 회의가 왜 소모적 또는 효율적이라고 생각하셨나요?"
    @State var sadClickCheck = false
    @State var sosoClickCheck = false
    @State var happyClickCheck = false
    @State var emojicheck = false
    @State var errorMessage : String = ""
    @State var keywords : [String] = []
    var gridItemLayout = [GridItem(.flexible())]
    
    @Environment(\.dismiss) var dismiss
    @Binding var firstSheetOpen: Bool
    
    func dependent(_ num : Int) -> String {
        switch num {
        case 1:
            return "‘ # ’을 포함해서 작성해주세요"
        case 2:
            return "띄어쓰기 없이 작성해주세요"
        case 3 :
            return "띄어쓰기 없이 #을 포함하여 작성해주세요"
        case 4 :
            return "중복된 회의 키워드입니다"
        default :
            return " "
        }
    }
    
    var body: some View {
        ZStack {
            Color.mainViewBlockGray
            
            VStack(spacing: 0) {
                headLine
                    .padding(.bottom, idEditing ? 0 : 45) // 하단 패딩값 45
                evaluation
                    .padding(.bottom, idEditing ? 0 : 50) // 하단 패딩 값 50
                meetingReview
                    .padding(.bottom, 52) // 하단 패딩 값 52
                meetingKeyword
//                    .padding(.bottom, 30) // 하단 패딩 값 30
                    .padding(.bottom, idEditing ? 160: 30) // 하단 패딩 값 30
                finishButton
                    .padding(.bottom, idEditing ? 0 : 40) // 하단 패딩 값 40
            }
            .navigationBarHidden(true) // navigationBar 숨기기.
            
            .interactiveDismissDisabled()
            .padding(.horizontal, 25)
        }
    }
    
    private var headLine: some View {
        VStack(spacing: 0) {
            Image(systemName: "face.smiling.inverse")
                .font(.system(size: 36, design: .default)) // 폰트크기 36, design default -> 폰트 디자인 종류 ^^
                .foregroundColor(.blue) // 글씨 파랑이
                .padding(.top, 48) // 상단 패딩값 48
                .padding(.bottom, 26) // 하단 패딩값 26
            Text("회의 종료!")
                .font(.pretendMedium20) // 미디움폰트 크기 20
                .foregroundColor(Color.sheetCategoryTextGray) // 글씨 색상 그레이
                .padding(.bottom, 16) // 하단 패딩값 16
            Text("이번 회의 어떠셨나요?")
                .font(.pretendSemibold30) // 세미볼드폰트 크기 30
        }
    }
    
    private var evaluation: some View {
        HStack(spacing : 36) { // 스페이싱 값 36
            VStack(spacing : 18){ // 스페이싱 값 18
                
                Button {
                    self.sadClickCheck.toggle() // 소모적 버튼 on
                    sosoClickCheck = false // 보통 버튼 off (중복선택 방지)
                    happyClickCheck = false // 효율적 버튼 off (중복선택 방지)
                } label: {
                    Text("😰")
                        .font(.system(size: 40)) // 시스템 기본폰트 크기 40
                        .opacity(sadClickCheck ? 1 : 0.4) // 삼항연산자. 소모적 토글이 활성화 되었을 때 오퍼시티 100%, 토글 비활성화시 오퍼시티 40%
                }
                
                Text("소모적")
                    .font(.pretendSemibold12) // 세미볼드 폰트크기 12
                
            }
            VStack(spacing : 18){ // 스페이싱 값 18
                Button {
                    self.sosoClickCheck.toggle() // 보통 버튼 on
                    sadClickCheck = false // 소모적 버튼 off (중복선택 방지)
                    happyClickCheck = false // 효율적 버튼 off (중복선택 방지)
                } label: {
                    Text("😐")
                        .font(.system(size: 40)) // 시스템 기본폰트 크기 40
                        .opacity(sosoClickCheck ? 1 : 0.4) // 삼항연산자. 보통 토글이 활성화 되었을 때 오퍼시티 100%, 토글 비활성화시 오퍼시티 40%
                }
                Text("보통")
                    .font(.pretendSemibold12) // 세미볼드 폰트크기 12
            }
            VStack(spacing : 18){ // 스페이싱 값 18
                Button{
                    self.happyClickCheck.toggle() // 효율적 버튼 on
                    sadClickCheck = false // 소모적 버튼 off (중복선택 방지)
                    sosoClickCheck = false // 보통 버튼 off (중복선택 방지)
                } label: {
                    Text("😊")
                        .font(.system(size: 40)) // 시스템 기본폰트 크기 40
                        .opacity(happyClickCheck ? 1 : 0.4) // 삼항연산자. 효율적 토글이 활성화 되었을 때 오퍼시티 100%, 토글 비활성화시 오퍼시티 40%
                }
                Text("효율적")
                    .font(.pretendSemibold12) // 세미볼드 폰트크기 12
            }
        }
    }
    
    private var meetingReview: some View {
        VStack(alignment: .leading,spacing: 0) { // 좌측 정렬. 제로 스페이싱.
            Text("회의 리뷰")
                .foregroundColor(Color.white) // 폰트 색상 화이트
                .font(.pretendSemibold16) // 세미볼드 폰트 크기 16
                .padding(.bottom, 10) // 하단 패딩 값 10
            
            ZStack(alignment: .topLeading) { // ZStack 좌측상단 정렬. 텍스트 에디터 위에 text를 ZStack으로 쌓음.
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.sheetBlockBackgroundGray)
                    .foregroundColor(Color.sheetFontWhite)// 폰트 색상 화이트
                
                TextEditor(text: $review)
                    .font(.pretendRegular18) // 레귤러 폰트 크기 18
                
                    .padding(EdgeInsets(top: 10, leading: 13, bottom: 9, trailing: 0))
                    .lineSpacing(1) // 라인스페이싱 1 -> 줄과 줄 사이의 거리
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .padding(.bottom,26) // 하단 패딩 값 26
                if review.isEmpty { // 회의 리뷰 값이 비어있는 경우
                    Text(placeholder) // 플레이스 홀더 ...
                        .foregroundColor(Color.primary.opacity(0.45)) // 폰트 색상 primary. 오퍼시티 0.45
                        .multilineTextAlignment(.leading) // 여러줄의 텍스트 표시 정렬. 좌측 정렬.
                        .position(x: 203, y: 28) // 위치 값 x 188, y 28
                }
                
            }
            .frame(width: 632, height: 80)
            .cornerRadius(8)
        }
    }
    
    
    private var meetingKeyword: some View {
        VStack{
            VStack(alignment: .leading) {
                HStack{
                    Text("회의 키워드")
                        .foregroundColor(Color.white)
                        .font(.pretendSemibold16)
                    Spacer()
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                    
                }
                .padding(.bottom, 10)
                
                TextField(
                    "타이틀",
                    text: $keyword,
                    prompt: Text(" #해시태그 입력 후 엔터를 눌러 등록해주세요")
                        .foregroundColor(Color.sheetPlaceholder)
                        .font(.pretendRegular18)
                )
                .frame(width: 632, height: 40)
                .padding(EdgeInsets(top: 10, leading: 13, bottom: 9, trailing: 0))
                .background(Color.sheetBlockBackgroundGray)
                .cornerRadius(8)
                .focused($idEditing)
                
                .onSubmit {
                    guard keyword != "" else { return }
                    if (Array(keyword)[0] != "#") && (Array(keyword).contains(" ")) {
                        errorMessage = dependent(3)
                    } else if (Array(keyword)[0] != "#") {
                        errorMessage = dependent(1)
                    } else if (Array(keyword).contains(" ")) {
                        errorMessage = dependent(2)
                    } else {
                        errorMessage = ""
                        keywords.append(keyword)
                    }
                    
                    keyword = ""
                }
                .padding(.bottom, 12)
                
                VStack{
                    LazyHGrid(rows : gridItemLayout) {
                        ForEach(keywords, id: \.self) { keyword in
                            Text(keyword)
                                .foregroundColor(.black)
                                .frame(height: 27)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(16)
                            
                        }
                        
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    
                }
            }
            .frame(width: 632, height: 40)
            .padding(.bottom, 31)
            .padding(.top, 26)
            
            VStack( spacing : 16) {
                Text("평가와 리뷰를 필수로 작성해주세요")
            }
            .foregroundColor(Color.white)
            .font(.pretendSemibold12)
        }
    }
    
    
    private var finishButton: some View {
        Button(action: {
            firstSheetOpen = false
        })
        {
            Text("저장하고 회의 마치기")
                .foregroundColor(Color.white)
                .font(.pretendSemibold16)
                .frame(width: 632, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue)
                        .opacity((sadClickCheck || sosoClickCheck || happyClickCheck) && !review.isEmpty ? 1: 0.4)
                }
        }
        .disabled(!((sadClickCheck || sosoClickCheck || happyClickCheck) && !review.isEmpty))
    }
}

//
//
//    struct MeetingAfterView_Previews: PreviewProvider {
//        static var previews: some View {
//            MeetingAfterView()
//                .previewInterfaceOrientation(.landscapeLeft)
//        }
//    }
//}
//

