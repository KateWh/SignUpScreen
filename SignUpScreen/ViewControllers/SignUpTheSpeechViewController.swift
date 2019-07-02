//
//  ViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/3/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignUpConstans {
    static let alertNameTitle = "Name too short!"
    static let alertNameMassage = "Must enter more than 3 characters."
    static let alertNameTitleAction = "Ok"
    static let alertPasswordTitle = "Wrong input!"
    static let alertPasswordMassage = "The password must contain only letters and numbers, from 6 to 16 characters."
    static let alertPasswordTitleAction = "Ok"
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
    static let minPasswordLength = 6
    static let maxPasswordLength = 16
}

class SignUpTheSpeechViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var scrollBottomConstaint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension SignUpTheSpeechViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField else {
            textField.resignFirstResponder()
            return true
        }
        nextField.becomeFirstResponder()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField && (textField.text == nil || textField.text!.count < 4) {
            showAlert(title: SignUpConstans.alertNameTitle, massage: SignUpConstans.alertNameMassage, preferredStyle: .alert, titleAction: SignUpConstans.alertNameTitleAction, styleAction: .default, handlerAction: nil)
            return false
        } else if textField == self.passwordTextField && (textField.text == nil || textField.text!.count < SignUpConstans.minPasswordLength || textField.text!.count > SignUpConstans.maxPasswordLength || !textField.text!.isAlphanumeric) {
                showAlert(title: SignUpConstans.alertPasswordTitle, massage: SignUpConstans.alertPasswordMassage, preferredStyle: .alert, titleAction: SignUpConstans.alertPasswordTitleAction, styleAction: .default, handlerAction: nil)
                return false
        }
        return true
    }
    
}

private extension SignUpTheSpeechViewController {
    
    func settingTextFields() {
        func setPaddingForTextField(_ textField: UITextField) {
            let spacerView = UIView(frame: CGRect(origin: SignUpConstans.spacePointForTextFields, size: SignUpConstans.spaceSizeForTextFields))
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = spacerView
        }
        
        setPaddingForTextField(nameTextField)
        setPaddingForTextField(usernameTextField)
        setPaddingForTextField(emailTextField)
        setPaddingForTextField(passwordTextField)
    }
    
    func showAlert(title: String?, massage: String?, preferredStyle: UIAlertController.Style, titleAction: String?, styleAction: UIAlertAction.Style, handlerAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: preferredStyle)
        let alertAction = UIAlertAction(title: titleAction, style: styleAction, handler: handlerAction)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion:  nil)
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrameSize = (userInfo [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        signUpScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide() {
        signUpScrollView.contentOffset = CGPoint.zero
    }
    
}
