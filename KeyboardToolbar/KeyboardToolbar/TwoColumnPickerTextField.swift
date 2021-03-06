//
//  TwoColumnPickerTextField.swift
//  KeyboardToolbar
//
//  Created by Kentarou on 2017/02/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit


class TwoColumnPickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerView = UIPickerView()
    let toolbarHeight: CGFloat = 44
    var dataArray1 = (1965...2017).map{ String($0) + "年" }
    var dataArray2 = (1...12).map{ String($0) + "月" }
    
    var selectYear = ""
    var selectMonth = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override var inputAccessoryView: UIView? {
        get {
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.black
            let doneButton   = UIBarButtonItem(title: "Done", style: .done,
                                               target: self,
                                               action: #selector(self.donePressed))
            let cancelButton = UIBarButtonItem(title: "Cancel",
                                               style: .plain,
                                               target: self,
                                               action: #selector(self.cancelPressed))
            let spaceButton  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                               target: nil,
                                               action: nil)
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            return toolBar
        }
        set {}
    }
    
    override var inputView: UIView? {
        get {
            pickerView.frame = CGRect(x: 0,
                                      y: toolbarHeight,
                                      width: UIScreen.main.bounds.size.width,
                                      height: pickerView.bounds.size.height)
            pickerView.delegate   = self
            pickerView.dataSource = self
            pickerView.backgroundColor = UIColor.white
            return pickerView
        }
        set {}
    }
    
    // Done
    func donePressed() {
        print("Done!")
        self.text = selectYear + " / " + selectMonth
        resignFirstResponder()
    }
    
    // Cancel
    func cancelPressed() {
        print("Cancel!")
        self.text = ""
        resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 表示行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 : return dataArray1.count
        case 1 : return dataArray2.count
        default: return 0
        }
    }
    
    // 各ラベルの幅
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        
        switch component {
        case 0 : return screenWidth / 2
        case 1 : return screenWidth / 2
        default: return 0
        }
    }
    
    //表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0 : return dataArray1[row]
        case 1 : return dataArray2[row]
        default: return nil
        }
    }
    
    //選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0 : selectYear = dataArray1[row]
        case 1 : selectMonth =  dataArray2[row]
        default: break
        }
    }
}

