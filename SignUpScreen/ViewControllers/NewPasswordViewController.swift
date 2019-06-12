//
//  NewPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var passwordEyeButtonIsOpen = true
    var repeatPasswordEyeButtonIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        
    }
    
    @IBAction func hideShowPasswordButton(_ sender: UIButton) {
        if !passwordEyeButtonIsOpen {
            passwordEyeButtonIsOpen = true
            sender.setImage(UIImage(named: "opened-eye-30x30.png"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordEyeButtonIsOpen = false
            sender.setImage(UIImage(named: "closed-eye-30x30.png"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func showHideRepeatPasswordButton(_ sender: UIButton) {
        if !repeatPasswordEyeButtonIsOpen {
            repeatPasswordEyeButtonIsOpen = true
            sender.setImage(UIImage(named: "opened-eye-30x30.png"), for: .normal)
            repeatPasswordTextField.isSecureTextEntry = false
            repeatPasswordTextField.textColor = .black
        } else {
            repeatPasswordEyeButtonIsOpen = false
            sender.setImage(UIImage(named: "closed-eye-30x30.png"), for: .normal)
            repeatPasswordTextField.isSecureTextEntry = true
            repeatPasswordTextField.textColor = .orange
        }
    }
    
}

extension NewPasswordViewController: UITextFieldDelegate {
    
    func settingTextFields() {
        passwordTextField.delegate = self
        passwordTextField.tag = 0
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.returnKeyType = UIReturnKeyType.go
        setPaddingForTextField(passwordTextField)
        repeatPasswordTextField.delegate = self
        repeatPasswordTextField.tag = 1
        repeatPasswordTextField.textColor = .orange
        repeatPasswordTextField.keyboardType = UIKeyboardType.emailAddress
        repeatPasswordTextField.returnKeyType = UIReturnKeyType.go
        setPaddingForTextField(repeatPasswordTextField)
    }
    
    func setPaddingForTextField(_ textField: UITextField) {
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
}
