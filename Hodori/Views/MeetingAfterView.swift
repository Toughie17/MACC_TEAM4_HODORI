//
//  MeetingAfterView.swift
//  Hodori
//
//  Created by Yujin Son on 2023/10/20.
//

import SwiftUI



struct MeetingAfterView: View {
    
    
    @State var review: String = ""
    @State var keyword: String = ""
    let placeholder: String = " 이번 회의가 왜 소모적 또는 효율적이라고 생각하셨나요?"
    //    @State var allChecked = false
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
              
                    Image(systemName: "face.smiling.inverse")
                        .font(.system(size: 36, design: .default))
                        .foregroundColor(.blue)
                        .padding(.top, 48)
                        .padding(.bottom, 26)
                    Text("회의 종료!")
                        .font(.pretendMedium20)
                        .foregroundColor(Color.sheetCategoryTextGray)
                        .padding(.bottom, 16)
                    Text("이번 회의 어떠셨나요?")
                        .font(.pretendSemibold30)
                        .padding(.bottom, 45)
                
                HStack(spacing : 36) {
                    VStack(spacing : 18){
                        Button {
                            self.sadClickCheck.toggle()
                            sosoClickCheck = false
                            happyClickCheck = false
                        } label: {
                            Text("😰")
                                .font(.system(size: 40))
                                .opacity(sadClickCheck ? 1 : 0.4)
                        }

                        Text("소모적")
                            .font(.pretendSemibold12)
                        
                    }
                    VStack(spacing : 18){
                        Button {
                            self.sosoClickCheck.toggle()
                            sadClickCheck = false
                            happyClickCheck = false
                        } label: {
                            Text("😐")
                                .font(.system(size: 40))
                                .opacity(sosoClickCheck ? 1 : 0.4)
                        }
                        Text("보통")
                            .font(.pretendSemibold12)
                    }
                    VStack(spacing : 18){
                        Button{
                            self.happyClickCheck.toggle()
                            sadClickCheck = false
                            sosoClickCheck = false
                        } label: {
                            Text("😊")
                                .font(.system(size: 40))
                                .opacity(happyClickCheck ? 1 : 0.4)
                        }
                        Text("효율적")
                            .font(.pretendSemibold12)
                    }
                }.padding(.bottom, 50) // HStack
                
                VStack(alignment: .leading,spacing: 0) {
                    Text("회의 리뷰")
                        .foregroundColor(Color.white)
                        .font(.pretendSemibold16)
                        .padding(.bottom, 10)
                    
                    ZStack(alignment: .topLeading) {
                        
                        TextEditor(text: $review)
                            .font(.pretendRegular18)
                            .foregroundColor(Color.white)
                            .lineSpacing(1)
                            .padding(.bottom,26)
                        if review.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color.primary.opacity(0.45))
                                .multilineTextAlignment(.leading)
                                .position(x: 188, y: 28)
                        }
                        
                    }
                    .frame(width: 632, height: 80)
                    .border(Color.sheetPlaceholder)
                    .ignoresSafeArea()
//                    .cornerRadius(8)
                    .padding(.bottom,52)
                }
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
                        prompt: Text("  #해시태그 입력 후 엔터를 눌러 등록해주세요")
                            .foregroundColor(Color.sheetPlaceholder)
                            .font(.pretendRegular18)

                    )
                    .frame(width: 632, height: 40)
                    .background(Color.sheetBlockBackgroundGray)
                    .cornerRadius(8)
                    .onSubmit {
                        guard keyword != "" else { return }
                        if (Array(keyword)[0] != "#") && (Array(keyword).contains(" ")) {
                            errorMessage = dependent(3)
                            
                        } else if (Array(keyword)[0] != "#") {
                            errorMessage = dependent(1)
                            
                        } else if (Array(keyword).contains(" ")) {
                            errorMessage = dependent(2)
                            
                            //                    } else if keywordDuplicateTest.contains(keyword) {
                            //                        errorMessage = dependent(4)
                            
                        } else {
                            errorMessage = ""
                            keywords.append(keyword)
                        }
                        
                        keyword = ""
                        //지우개
                        
                        
                    }
                    .padding(.bottom, 12)
                    
                    //                .onTapGesture {
                    //
                    //                }
                    VStack{
                        LazyHGrid(rows : gridItemLayout){
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
                        .padding(.bottom, 30)
                        //                        .position(x: 328, y: 30)
                        
                        
                    }
                }
                
                .frame(width: 632, height: 40)
                .padding(.bottom, 31)
                .padding(.top, 26)
                
                
                VStack( spacing : 16) {
                    Text("평가와 리뷰를 필수로 작성해주세요")
                        .foregroundColor(Color.white)
                        .font(.pretendSemibold12)
                      
                    
                    
                    Button(action: {
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
            }// VStack
         

        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .interactiveDismissDisabled()
        .padding(.horizontal, 25)
        .padding(.bottom,40)
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

