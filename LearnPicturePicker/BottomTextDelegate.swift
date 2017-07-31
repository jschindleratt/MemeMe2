//
//  BottomTextDelegate.swift
//  LearnPicturePicker
//
//  Created by Joshua Schindler on 7/12/17.
//  Copyright © 2017 Joshua Schindler. All rights reserved.
//

import Foundation
import UIKit
class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }  
}
