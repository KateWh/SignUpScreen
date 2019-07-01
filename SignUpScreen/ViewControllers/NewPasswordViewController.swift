//
//  NewPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct NewPasswordConstants {
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let topSaveButtonConstraint: CGFloat = 58
    static let topViewConstraint: CGFloat = 72
    static let tenPointers: CGFloat = 10
    static let threePointers: CGFloat = 3
    static let passwordMin = 6
    static let passwordMax = 16
    static let saveButtonEnableBackgroundColor = #colorLiteral(red: 0.9287405014, green: 0.4486459494, blue: 0.01082476228, alpha: 1)
    static let saveButtonDisableBackgroundColor = #colorLiteral(red: 0.9385811687, green: 0.6928147078, blue: 0.4736688733, alpha: 1)
}

class NewPasswordViewController: BaseTextFieldViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showRepeatPasswordButton: UIButton!
    
    @IBOutlet weak var doNotMatchPasswordLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var topConstraintSaveButton: NSLayoutConstraint!
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    
    var currentPassword = ""
    var repeatPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTextFields()
        self.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        if sender.tag == 0 {
            self.changePasswordView(passwordTextField, button: sender)
        } else {
            self.changePasswordView(repeatPasswordTextField, button: sender)
        }
    }
    
}

private extension NewPasswordViewController {
    
    func settingTextFields() {
        setPaddingForTextField(passwordTextField)
        setPaddingForTextField(repeatPasswordTextField)
    }

    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrameSize = (userInfo [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // Save the distance which you want a use to raise the button.
        var interval = (keyboardFrameSize.minY - NewPasswordConstants.tenPointers) - saveButton.frame.maxY
        guard interval < 0 else { return }
        
        // Check the ratio of the height of the button constraint to the height at which you want to raise the button.
        switch (topConstraintSaveButton.constant - NewPasswordConstants.threePointers) + interval {
        // If the constraint height larger, simply subtract the height of the decrease from it.
        case 0...:
            topConstraintSaveButton.constant += interval
            topConstraintView.constant = NewPasswordConstants.topViewConstraint
        // If the height of the decrease larger, subtract constraint height(without the minimum possible) from it, set minimum possible constraint height and subtract the remaining height of the decrease from the height of the view constraint.
        case ..<0:
            interval += topConstraintSaveButton.constant - NewPasswordConstants.threePointers
            topConstraintSaveButton.constant = NewPasswordConstants.threePointers
            topConstraintView.constant += interval
            
        default:
            break
        }
    }
    
    @objc func keyboardWillHide() {
        topConstraintSaveButton.constant = NewPasswordConstants.topSaveButtonConstraint
        topConstraintView.constant = NewPasswordConstants.topViewConstraint
    }
    
    func changePasswordView(_ textField: UITextField, button: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        button.isSelected = !button.isSelected
    }
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        
        if updatedString.count >= NewPasswordConstants.passwordMin &&
            updatedString.count <= NewPasswordConstants.passwordMax &&
            (textField == passwordTextField &&
                updatedString == self.repeatPassword ||
                textField == repeatPasswordTextField &&
                updatedString == self.currentPassword) {
            self.saveButton.backgroundColor = NewPasswordConstants.saveButtonEnableBackgroundColor
            self.saveButton.isEnabled = true
            self.doNotMatchPasswordLabel.isHidden = true
            
        } else {
            self.saveButton.backgroundColor = NewPasswordConstants.saveButtonDisableBackgroundColor
            self.saveButton.isEnabled = false
            self.doNotMatchPasswordLabel.isHidden = false
        }
        
        if textField == passwordTextField {
            self.currentPassword = updatedString
        } else if textField == repeatPasswordTextField {
            self.repeatPassword = updatedString
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == repeatPasswordTextField, repeatPasswordTextField.text != nil {
            
        }
        return true
    }
    
}
