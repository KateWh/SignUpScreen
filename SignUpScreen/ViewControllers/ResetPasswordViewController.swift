//
//  ResetPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct ResetPasswordConstants {
    static let goToSignInSegueIdentifire = "goToSignIn"
    static let startButtonTitle = "START"
    static let startStringSomeQuestionLabel = "Please, enter the password from the letter."
    static let startPlaceholder = "Password"
    static let segueToNewPasswordScreen = "goToNewPassword"
    static let sendButtonEnableBackgroundColor = #colorLiteral(red: 0.9287405014, green: 0.4486459494, blue: 0.01082476228, alpha: 1)
    static let sendButtonDisableBackgroundColor = #colorLiteral(red: 0.9385811687, green: 0.6928147078, blue: 0.4736688733, alpha: 1)
}

enum ControllerState {
    case setEmail
    case setPassword
}

class ResetPasswordViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var criteriaOfPassword: UILabel!
    
    var controllerState = ControllerState.setEmail
    
    override func performToSegue() {
         self.performSegue(withIdentifier: ResetPasswordConstants.goToSignInSegueIdentifire, sender: self)
    }
    
    override func settingTextFields() {
        super.setPaddingForTextField(emailTextField)
    }
    
    @IBAction func tapSendButton(_ sender: UIButton) {
        self.goNext()
    }
    
}

extension ResetPasswordViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        if controllerState == ControllerState.setEmail && BaseConstants.emailPredicate.evaluate(with: updatedString) {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = ResetPasswordConstants.sendButtonEnableBackgroundColor
        } else if controllerState == ControllerState.setPassword && BaseConstants.passwordPredicate.evaluate(with: updatedString) &&
            updatedString.isAlphanumeric {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = ResetPasswordConstants.sendButtonEnableBackgroundColor
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = ResetPasswordConstants.sendButtonDisableBackgroundColor
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isReturn = super.goToTheNext(textField: textField)
        if isReturn && self.nextButton.isEnabled {
           self.goNext()
        }
        return isReturn
    }
}

private extension ResetPasswordViewController {
    
    func goNext() {
        if controllerState == ControllerState.setEmail {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = ResetPasswordConstants.sendButtonDisableBackgroundColor
            self.someQuestionsLabel.text = ResetPasswordConstants.startStringSomeQuestionLabel
            self.emailTextField.placeholder = ResetPasswordConstants.startPlaceholder
            self.emailTextField.text?.removeAll()
            self.emailTextField.endFloatingCursor()
            self.criteriaOfPassword.isHidden = true
            self.nextButton.setTitle(ResetPasswordConstants.startButtonTitle, for: .normal)
            self.controllerState = ControllerState.setPassword
        } else if controllerState == ControllerState.setPassword {
            performSegue(withIdentifier: ResetPasswordConstants.segueToNewPasswordScreen, sender: self)
        }
    }
    
}
