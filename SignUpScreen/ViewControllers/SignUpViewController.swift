//
//  SecondSignUpScreenViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignUpConstans {
    static let mainStringSomeQuestionLabel = "Already have an account? "
    static let subStringSomeQuestionLabel = "Sign in"
    static let unwindSegueIdentifire = "unwindSegueToSignIn"
    static let passwordMin = 6
    static let passwordMax = 16
    static let startButtonEnableBackgroundColor = #colorLiteral(red: 0.9287405014, green: 0.4486459494, blue: 0.01082476228, alpha: 1)
    static let startButtonDisableBackgroundColor = #colorLiteral(red: 0.9385811687, green: 0.6928147078, blue: 0.4736688733, alpha: 1)
}


class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordRulesLabel: UILabel!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var secondSignUpScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSomeQuestionsLabel()
    }
    
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
        
        if textField == passwordTextField {
            if updatedString.count >= 0 {
                self.showPasswordButton.isHidden = false
                self.showPasswordButton.isEnabled = true
            } else {
                self.showPasswordButton.isHidden = true
                self.showPasswordButton.isEnabled = false
            }
            if updatedString.count >= SignUpConstans.passwordMin && updatedString.count <= SignUpConstans.passwordMax {
                self.passwordRulesLabel.isHidden = true
                if nameTextField.text != nil && usernameTextField.text != nil && emailTextField.text != nil {
                    self.passwordTextField.layer.borderWidth = 0
                    self.startButton.backgroundColor = SignUpConstans.startButtonEnableBackgroundColor
                    self.startButton.isEnabled = true
                }
            } else {
                passwordRulesLabel.isHidden = false
                
            }
        } else {
            if nameTextField.text != nil && usernameTextField.text != nil && emailTextField.text != nil && passwordTextField.text?.count ?? 0 >= SignUpConstans.passwordMin && passwordTextField.text?.count ?? 0 <= SignUpConstans.passwordMax {
                self.startButton.backgroundColor = SignUpConstans.startButtonEnableBackgroundColor
                self.startButton.isEnabled = true
                
            } else {
                self.startButton.backgroundColor = SignUpConstans.startButtonDisableBackgroundColor
                self.startButton.isEnabled = false
            }
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

private extension SignUpViewController {

    func setupSomeQuestionsLabel() {
        super.makeTheSubstringOrange(label: super.someQuestionsLabel, mainString: SignUpConstans.mainStringSomeQuestionLabel, subStringForColoring: SignUpConstans.subStringSomeQuestionLabel)
        super.someQuestionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
    }
    
}
