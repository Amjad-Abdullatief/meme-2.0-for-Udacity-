//
//  textFieldDelegate.swift
//  meme 1.0
//
//  Created by AMJAD - on 03/02/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject ,UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
