//
//  CustomPicker.swift
//  Hodori
//
//  Created by Yujin Son on 2023/11/14.
//
import SwiftUI

struct CustomPicker: UIViewRepresentable {
    @Binding var sec : Double
    
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func makeUIView(context: Context) -> UIPickerView {

        let pickerView = UIPickerView(frame:.zero)
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
       

        
        
        let font = UIFont.systemFont(ofSize: 20.0)
               let fontSize: CGFloat = font.pointSize
               let componentWidth: CGFloat = pickerView.frame.width / CGFloat(pickerView.numberOfComponents)
               let y = (pickerView.frame.size.height / 2) - (fontSize / 2)
               
               let label1 = UILabel(frame: CGRect(x: componentWidth * 0.5, y: y, width: componentWidth * 0.4, height: fontSize))
               label1.font = font
               label1.textAlignment = .left
               label1.text = "시간"
               label1.textColor = UIColor.lightGray
               pickerView.addSubview(label1)

        let label2 = UILabel(frame: CGRect(x: componentWidth * 1.10, y: y, width: componentWidth * 0.4, height: fontSize))
               label2.font = font
               label2.textAlignment = .left
               label2.text = "분"
               label2.textColor = UIColor.lightGray
               pickerView.addSubview(label2)
    



        return pickerView
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        let totalSeconds = Int($sec.wrappedValue)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
 
        uiView.selectRow(hours, inComponent: 0, animated: false)
        uiView.selectRow(minutes / 5, inComponent: 1, animated: false)
   
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(sec: $sec)
    }
    
    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        let sec: Binding<Double>
        let values: [Int] = Array(0..<100)
        
        init(sec: Binding<Double>) {
            self.sec = sec
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return component == 0 ? 24 : 60 / 5

        }
    
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(values[row])"
        }
        else {
            return "\(values[row * 5])"
        }
    }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 90
        }
   
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let hourIndex = pickerView.selectedRow(inComponent: 0)
            let minIndex = pickerView.selectedRow(inComponent: 1)

            
            sec.wrappedValue = Double((minIndex*60 * 5 )+(hourIndex*3600))
        }
    
    }
    
}

#Preview {
    CustomPicker(sec : Binding.constant(0))
}

