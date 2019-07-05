//
//  SignInViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignInConstans {
    static let mainStringForgotYourPasswordLabel = "Forgot your password? "
    static let orangeStringForgotYourPasswordLabel = "Tap to reset"
    static let goToSignUpSegueIdentifire = "goToSignUp"
    static let goToResetSegueIdentifire = "goToReset"
}

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var forgotYourPasswordLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupForgotYourPasswordLabel()
    }
    
    override func performToSegue() {
        performSegue(withIdentifier: SignInConstans.goToSignUpSegueIdentifire, sender: self)
    }
    
    override func settingTextFields() {
        super.setPaddingForTextField(emailTextField)
        super.setPaddingForTextField(passwordTextField)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.emailTextField.text?.removeAll()
        super.passwordTextField.text?.removeAll()
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        
        if textField == emailTextField {
            if updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.oneHundredSixtyEightInt && BaseConstants.emailPredicate.evaluate(with: updatedString) && BaseConstants.passwordPredicate.evaluate(with: passwordTextField.text ?? "") {
                self.nextButton.backgroundColor = BaseConstants.orange
                self.nextButton.isEnabled = true
            } else {
                self.nextButton.backgroundColor = BaseConstants.lightOrange
                self.nextButton.isEnabled = false
            }
            
        } else if textField == passwordTextField {
            if updatedString.count >= BaseConstants.sixInt && updatedString.count <= BaseConstants.twentyInt && BaseConstants.passwordPredicate.evaluate(with: updatedString) {
                self.incorrectPasswordLabel.isHidden = true
                self.passwordTextField.layer.borderWidth = 0
                if BaseConstants.emailPredicate.evaluate(with: emailTextField.text) {
                    self.nextButton.backgroundColor = BaseConstants.orange
                    self.nextButton.isEnabled = true
                } else {
                    self.nextButton.backgroundColor = BaseConstants.lightOrange
                    self.nextButton.isEnabled = false
                }
                
            } else {
                self.incorrectPasswordLabel.isHidden = false
                self.nextButton.backgroundColor = BaseConstants.lightOrange
                self.nextButton.isEnabled = false
            }
        }
        
        if updatedString.count > 0 {
            self.showPasswordButton.isHidden = false
            self.showPasswordButton.isEnabled = true
        } else {
            self.showPasswordButton.isHidden = true
            self.showPasswordButton.isEnabled = false
            self.passwordTextField.isSecureTextEntry = true
            self.incorrectPasswordLabel.isHidden = true
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

private extension SignInViewController {
    
    func setupForgotYourPasswordLabel() {
        super.makeTheSubstringOrange(label: self.forgotYourPasswordLabel, mainString: SignInConstans.mainStringForgotYourPasswordLabel, subStringForColoring: SignInConstans.orangeStringForgotYourPasswordLabel)
        
        self.forgotYourPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnFogotLabel)))
    }
    
    @objc func handleTapOnFogotLabel(_ recognizer: UITapGestureRecognizer) {
        guard let dontHaveText = forgotYourPasswordLabel.attributedText?.string else { return }
        
        if let range = dontHaveText.range(of: NSLocalizedString(SignInConstans.orangeStringForgotYourPasswordLabel, comment: "")),
            recognizer.didTapAttributedTextInLabel(label: self.forgotYourPasswordLabel, inRange: NSRange(range, in: SignInConstans.mainStringForgotYourPasswordLabel)) {
            performSegue(withIdentifier: SignInConstans.goToResetSegueIdentifire, sender: self)
        }
    }
    
}
