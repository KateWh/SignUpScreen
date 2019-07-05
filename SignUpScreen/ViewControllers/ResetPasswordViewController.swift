//
//  ResetPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct ResetPasswordConstants {
    static let unwindToSignInSegueIdentifire = "unwindToSignIn"
    static let startButtonTitle = "START"
    static let startStringSomeQuestionLabel = "Please, enter the password from the letter."
    static let startPlaceholder = "Password"
    static let segueToNewPasswordScreen = "goToNewPassword"
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
         self.performSegue(withIdentifier: ResetPasswordConstants.unwindToSignInSegueIdentifire, sender: self)
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
        
        if controllerState == ControllerState.setEmail && updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.oneHundredSixtyEightInt && BaseConstants.emailPredicate.evaluate(with: updatedString) {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = BaseConstants.orange
        } else if controllerState == ControllerState.setPassword && updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.twentyInt && BaseConstants.passwordPredicate.evaluate(with: updatedString) {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = BaseConstants.orange
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = BaseConstants.lightOrange
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
            self.nextButton.backgroundColor = BaseConstants.lightOrange
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
