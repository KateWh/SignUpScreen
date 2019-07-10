//
//  SecondSignUpScreenViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignUpConstans {
    static let unwindSegueIdentifire = "unwindToSignIn"
    static let passwordRulesText = "The password should be 6 to 20 characters long, must contain at least 1 uppercase and 1 number (0-9)"
}

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordRulesLabel: UILabel!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var nameCheckButton: UIButton!
    @IBOutlet weak var usernameCheckButton: UIButton!
    @IBOutlet weak var emailCheckButton: UIButton!
    @IBOutlet weak var passwordCheckButton: UIButton!
    
    override func performToSegue() {
        self.performSegue(withIdentifier: SignUpConstans.unwindSegueIdentifire, sender: self)
    }
    
    override func settingTextFields() {
        super.setPaddingForTextField(nameTextField)
        super.setPaddingForTextField(usernameTextField)
        super.setPaddingForTextField(emailTextField)
        super.setPaddingForTextField(passwordTextField)
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        
        if textField == nameTextField {
            if updatedString.count >= BaseConstants.twoInt && updatedString.count <= BaseConstants.fiftyInt {
                self.nameCheckButton.isHidden = false
            } else {
                self.nameCheckButton.isHidden = true
            }
        } else if textField == usernameTextField {
            if updatedString.count >= BaseConstants.twoInt && updatedString.count <= BaseConstants.fiftyInt {
                self.usernameCheckButton.isHidden = false
            } else {
                self.usernameCheckButton.isHidden = true
            }
        } else if textField == emailTextField {
            if updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.oneHundredSixtyEightInt && BaseConstants.emailPredicate.evaluate(with: updatedString) {
                self.emailCheckButton.isHidden = false
            } else {
                self.emailCheckButton.isHidden = true
            }
        } else if textField == passwordTextField {
            if updatedString.count >= 0 {
                self.showPasswordButton.isHidden = false
                self.showPasswordButton.isEnabled = true
            } else {
                self.showPasswordButton.isHidden = true
                self.showPasswordButton.isEnabled = false
            }
            if updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.twentyInt && BaseConstants.passwordPredicate.evaluate(with: updatedString) {
                self.passwordCheckButton.isHidden = false
                self.passwordRulesLabel.text = BaseConstants.emptyString
            } else {
                passwordRulesLabel.text = SignUpConstans.passwordRulesText
                self.passwordCheckButton.isHidden = true
            }
        }
        
        if !nameCheckButton.isHidden && !usernameCheckButton.isHidden && !emailCheckButton.isHidden && !passwordCheckButton.isHidden {
            self.nextButton.backgroundColor = BaseConstants.orange
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.backgroundColor = BaseConstants.lightOrange
            self.nextButton.isEnabled = false
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        super.makeGreyBorder(textField: textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return super.goToTheNext(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        super.hideBorder(textField: textField)
    }
    
}
