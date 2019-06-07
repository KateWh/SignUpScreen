//
//  SecondSignUpScreenViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SecondSignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var secondSignUpScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondSignUpScrollView.delegate = self
        settingTextFields()
    }
    
}

extension SecondSignUpViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }

}

extension SecondSignUpViewController: UITextFieldDelegate {
    
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
    
}
