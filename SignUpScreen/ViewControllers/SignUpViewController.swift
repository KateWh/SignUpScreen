//
//  ViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/3/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var scrollBottomConstaint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        signUpScrollView.delegate = self
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
}

extension SignUpViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func settingTextFields() {
        nameTextField.delegate = self
        nameTextField.tag = 0
        nameTextField.returnKeyType = UIReturnKeyType.next
        setPaddingForTextField(nameTextField)
        usernameTextField.delegate = self
        usernameTextField.tag = 1
        usernameTextField.returnKeyType = UIReturnKeyType.next
        setPaddingForTextField(usernameTextField)
        emailTextField.delegate = self
        emailTextField.tag = 2
        emailTextField.returnKeyType = UIReturnKeyType.next
        setPaddingForTextField(emailTextField)
        passwordTextField.delegate = self
        passwordTextField.tag = 3
        passwordTextField.returnKeyType = UIReturnKeyType.done
        setPaddingForTextField(passwordTextField)
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
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            if textField.text?.count ?? 0 < 4 {
                showAlert(title: "Name too short!", massage: "Must enter more than 3 characters.", preferredStyle: .alert, titleAction: "Ok", styleAction: .default, handlerAction: nil)
                return false
            }
        case 3:
            let text = textField.text ?? ""
            if !checkLength(textField.text, range: (6,16)) || !text.isAlphanumeric  {
                showAlert(title: "Wrong input!", massage: "The password must contain only letters and numbers, from 6 to 16 characters.", preferredStyle: .alert, titleAction: "Ok", styleAction: .default, handlerAction: nil)
                return false
            }
        default:
            break
        }
        return true
    }

    func checkLength(_ string: String?, range: (Int,Int)) -> Bool {
        if let string = string {
            switch string.count{
            case range.0...range.1:
                return true
            default:
                break
            }
        }
        return false
    }
    
}

extension SignUpViewController {
    
    func showAlert(title: String?, massage: String?, preferredStyle: UIAlertController.Style, titleAction: String?, styleAction: UIAlertAction.Style, handlerAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: preferredStyle)
        let alertAction = UIAlertAction(title: titleAction, style: styleAction, handler: handlerAction)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion:  nil)
    }
    
}

extension SignUpViewController {
    
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
        let conternInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        signUpScrollView.contentInset = conternInset
    }
    
    @objc func keyboardWillHide() {
        signUpScrollView.contentOffset = CGPoint.zero
    }
    
}

extension String {
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
}
