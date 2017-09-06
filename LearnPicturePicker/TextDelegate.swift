//
//  TextDelegate.swift
//  MemeMe2
//
//  Created by Joshua Schindler on 9/6/17.
//  Copyright © 2017 Joshua Schindler. All rights reserved.
//

import UIKit

class TextDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        if textField.text == "TOP" || textField.text == "BOTTOM"  {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
