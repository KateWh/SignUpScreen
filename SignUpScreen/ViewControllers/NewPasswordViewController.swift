//
//  NewPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct NewPasswordConstants {
    static let passwordHint = "The password should be 6 to 20 characters long, must contain at least 1 uppercase and 1 number (0-9)"
    static let passwordNotMatch = "Passwords do not match. Try again."
}

class NewPasswordViewController: BaseViewController {

    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showRepeatPasswordButton: UIButton!
    @IBOutlet weak var passwordRuleLabel: UILabel!
    
    override func settingTextFields() {
        setPaddingForTextField(passwordTextField)
        setPaddingForTextField(repeatPasswordTextField)
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        if sender.tag == 0 {
            super.changePasswordView(super.passwordTextField, button: sender)
        } else {
            super.changePasswordView(self.repeatPasswordTextField, button: sender)
            
            if self.repeatPasswordTextField.isSecureTextEntry {
               self.repeatPasswordTextField.textColor = BaseConstants.lightOrange
            } else {
                self.repeatPasswordTextField.textColor = BaseConstants.black
            }
        }
    }
    
}

extension NewPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == super.passwordTextField {
            self.passwordRuleLabel.text = NewPasswordConstants.passwordHint
            self.passwordRuleLabel.textColor = BaseConstants.black
        } else if textField == self.repeatPasswordTextField {
            self.passwordRuleLabel.text = NewPasswordConstants.passwordNotMatch
            self.passwordRuleLabel.textColor = BaseConstants.lightOrange
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }

            if textField == super.passwordTextField {
                if updatedString.count > 0 {
                    self.showPasswordButton.isEnabled = true
                    self.showPasswordButton.isHidden = false
                } else {
                    self.showPasswordButton.isEnabled = false
                    self.showPasswordButton.isHidden = true
                }
                self.passwordRuleLabel.text = NewPasswordConstants.passwordHint
                self.passwordRuleLabel.textColor = BaseConstants.black
            } else if textField == self.repeatPasswordTextField {
                if updatedString.count > 0 {
                    self.showRepeatPasswordButton.isHidden = false
                    self.showRepeatPasswordButton.isEnabled = true
                } else {
                    self.showRepeatPasswordButton.isHidden = true
                    self.showRepeatPasswordButton.isEnabled = false
                }
                self.passwordRuleLabel.text = NewPasswordConstants.passwordNotMatch
                self.passwordRuleLabel.textColor = BaseConstants.lightOrange
            }
        
        if textField == self.passwordTextField && updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.twentyInt && BaseConstants.passwordPredicate.evaluate(with: updatedString) && self.repeatPasswordTextField.text == updatedString {
                self.nextButton.backgroundColor = BaseConstants.orange
                self.nextButton.isEnabled = true
                self.passwordRuleLabel.isHidden = true
        } else if textField == self.repeatPasswordTextField && updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.twentyInt && BaseConstants.passwordPredicate.evaluate(with: updatedString) && self.passwordTextField.text == updatedString {
                self.nextButton.backgroundColor = BaseConstants.orange
                self.nextButton.isEnabled = true
                self.passwordRuleLabel.isHidden = true
        } else {
            self.passwordRuleLabel.isHidden = false
            self.nextButton.backgroundColor = BaseConstants.lightOrange
            self.nextButton.isEnabled = false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return super.goToTheNext(textField: textField)
    }
    
}
