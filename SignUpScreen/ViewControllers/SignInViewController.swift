//
//  SignInViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    var eyeButtonIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        setupSomeQuestionsLabel()
    }
    
    @IBAction func showHidePassword(_ sender: UIButton) {
        if !eyeButtonIsOpen {
            eyeButtonIsOpen = true
            sender.setImage(UIImage(named: "opened-eye-30x30.png"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        } else {
            eyeButtonIsOpen = false
            sender.setImage(UIImage(named: "closed-eye-30x30.png"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func settingTextFields() {
        emailTextField.delegate = self
        emailTextField.tag = 0
        emailTextField.returnKeyType = UIReturnKeyType.next
        setPaddingForTextField(emailTextField)
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        passwordTextField.returnKeyType = UIReturnKeyType.done
        setPaddingForTextField(passwordTextField)
    }
    
    func setPaddingForTextField(_ textField: UITextField) {
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.499868989, green: 0.5142127275, blue: 0.5874249935, alpha: 1).cgColor
        return true
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
}

extension SignInViewController {
    
    func setupSomeQuestionsLabel() {
        let mainString = "Don't have an account? Sign up"
        let subStringToColor = "Sign up"

        let range = (mainString as NSString).range(of: subStringToColor)
        let attributes = NSMutableAttributedString.init(string: mainString)
        attributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        someQuestionsLabel.attributedText = attributes
    }
    
}
