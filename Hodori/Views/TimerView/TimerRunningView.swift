//
//  TimerRunningView.swift
//  Hodori
//
//  Created by Yujin Son on 2023/11/14.
//

import SwiftUI

struct TimerRunningView: View {
    
    @Binding var sec : Double
    let date = Date()
    @State var timeRemaining : Int = 0
    @State private var blinkTimer: Timer?
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isClicked = false
    @State private var animate = false
    let feedback = UIImpactFeedbackGenerator(style: .soft)
    @State private var isBlinking = false
    
    //    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            HStack {
                HStack {
                    Button {
                        isClicked.toggle()
                        if isClicked {
                            stopTimer()
                            startStopBlinking()
                        } else {
                            startTimer()
                            stopBlinking()
                        }
                    } label: {
                        HStack {
                            Image(systemName: isClicked ? "play.fill" : "pause.fill")
                                .resizable()
                                .frame(width: 14, height: 19)
                                .font(Font.system(size: 24, weight: .ultraLight))
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(Color.gray))
                                .frame(width: 40, height: 40)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 4)
                    
                    
                    Button {
                        //                self.stopTimer()
                        // 들어갈 거 -> 타이머 종료하기 + 시간 값 리셋?
                        // 들어갈 거 -> 타이머 뷰 사라지기
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 14, height: 19)
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(Color.gray))
                                .frame(width: 40, height: 40)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 30)
                    //            .onChange(of: stopTimer) { newValue in
                    //                print("STOP")
                }
                .padding(.leading, 20)
                
                HStack {
                    Text("남은 시간")
                        .font(.system(size: 14))
                    
                    //                    .font(T##font: Font?##Font?)
                        .padding(.trailing, 8)
                        .padding(.top, 38)
                        .padding(.bottom, 22)


                    ZStack {
                        Text(convertSecondsToTime(timeInSeconds:timeRemaining))
                            .font(.system(size: 40))
                            .foregroundColor(isBlinking ? .clear : .black)
                            .onAppear {
                                startStopBlinking() // 뷰가 나타날 때 깜빡이기 시작
                            }
                            .onReceive(timer) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                    if timeRemaining == 0 {
                                        stopTimer()
                                        feedback.impactOccurred()
                                        SoundManager.instance.playSound()
                                        
                                    }
                                }
                            }
                    }
                    .onAppear {
                        calcRemain()
                    }
                }
                .padding(.vertical, 12)
                .padding(.trailing, 20)
            }
        }
    }
        
        func convertSecondsToTime(timeInSeconds: Int) -> String {
            let hours = timeInSeconds / 3600
            let minutes = (timeInSeconds - hours*3600) / 60
//            let seconds = timeInSeconds % 60
            return String(format: "%02i:%02i", hours,minutes)
        }
        
        
        func calcRemain() {
            let calendar = Calendar.current // 현재 시간 저장
            let targetTime : Date = calendar.date(byAdding: .second, value: Int($sec.wrappedValue), to: date, wrappingComponents: false) ?? Date() // 설정한 초들을 date 형식으로 바꿔서 calendar에 저장
            self.timeRemaining =  Int(targetTime.timeIntervalSince(date)) // timeRemaining에 시간 값을 바로 넣게 변형
            
        }
        
        func stopTimer() {
            
            self.timer.upstream.connect().cancel()
        }
        
        func startTimer() {
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        private func startStopBlinking() {
            if isClicked {
                blinkTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    withAnimation {
                        self.isBlinking.toggle()
                    }
                }
            } else {
                stopBlinking()
            }
        }
        
        private func stopBlinking() {
            blinkTimer?.invalidate()
            blinkTimer = nil
            withAnimation {
                self.isBlinking = false
            }
        }
    }
    
    struct InputTest_Previews: PreviewProvider {
        static var previews: some View {
            TimerRunningView(sec: Binding.constant(0))
        }
    }

