//
//  ResetPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    
    @IBOutlet weak var topConstraintSendButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        setupSingInText()
        registerKeyboardNotification()
    }
    
}

extension ResetPasswordViewController: UITextFieldDelegate {
    
    func settingTextFields() {
        emailTextField.delegate = self
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.go
        setPaddingForTextField(emailTextField)
    }
    
    func setPaddingForTextField(_ textField: UITextField) {
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
    }
    
}

extension ResetPasswordViewController {
    
    func setupSingInText() {
        let mainString = "Do you remember your password? Sign in"
        let subStringToColor = "Sign in"
        
        let range = (mainString as NSString).range(of: subStringToColor)
        let attributes = NSMutableAttributedString.init(string: mainString)
        attributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        someQuestionsLabel.attributedText = attributes
    }
    
}

extension ResetPasswordViewController {
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrameSize = (userInfo [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let interval = (keyboardFrameSize.minY - 3) - sendButton.frame.maxY
        if interval < 0 {
            topConstraintSendButton.constant += interval
        }
    }
    
    @objc func keyboardWillHide() {
        topConstraintSendButton.constant = Constants.topSendButtonConstraint
    }
    
}

