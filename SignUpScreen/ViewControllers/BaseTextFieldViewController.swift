//
//  BaseTextFieldViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

struct BaseConstants {
    static let borderWidth: CGFloat = 2
    static let borderColor: CGColor = #colorLiteral(red: 0.499868989, green: 0.5142127275, blue: 0.5874249935, alpha: 1).cgColor
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
}

class BaseTextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotification()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension BaseTextFieldViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = BaseConstants.borderWidth
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField else {
            textField.resignFirstResponder()
            return true
        }
        nextField.becomeFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
}

extension BaseTextFieldViewController {
    
    func setPaddingForTextField(_ textField: UITextField) {
        let spacerView = UIView(frame: CGRect(origin: BaseConstants.spacePointForTextFields, size: BaseConstants.spaceSizeForTextFields))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.layer.borderColor = BaseConstants.borderColor
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
       
    }
    
    @objc func keyboardWillHide() {
        
    }
    
}

