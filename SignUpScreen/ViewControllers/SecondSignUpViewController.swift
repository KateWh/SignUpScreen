//
//  SecondSignUpScreenViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SecondSignUpConstans {
    static let mainStringSomeQuestionLabel = "Already have an account? Sign in"
    static let signInText = "Sign in"
    static let unwindSegueIdentifire = "unwindSegueToSignIn"
    static let passwordMin = 6
    static let passwordMax = 16
    static let startButtonEnableBackgroundColor = #colorLiteral(red: 0.9287405014, green: 0.4486459494, blue: 0.01082476228, alpha: 1)
    static let startButtonDisableBackgroundColor = #colorLiteral(red: 0.9385811687, green: 0.6928147078, blue: 0.4736688733, alpha: 1)
}


class SecondSignUpViewController: BaseTextFieldViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var someQuestionsLabel: UILabel!
    @IBOutlet weak var passwordRulesLabel: UILabel!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var secondSignUpScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTextFields()
        self.setupSomeQuestionsLabel()
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    

}

extension SecondSignUpViewController {
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
            if updatedString.count >= SecondSignUpConstans.passwordMin && updatedString.count <= SecondSignUpConstans.passwordMax {
                self.passwordRulesLabel.isHidden = true
                if nameTextField.text != nil && usernameTextField.text != nil && emailTextField.text != nil {
                    self.passwordTextField.layer.borderWidth = 0
                    self.startButton.backgroundColor = SecondSignUpConstans.startButtonEnableBackgroundColor
                    self.startButton.isEnabled = true
                }
            } else {
                passwordRulesLabel.isHidden = false
                
            }
        } else {
            if nameTextField.text != nil && usernameTextField.text != nil && emailTextField.text != nil && passwordTextField.text?.count ?? 0 >= SecondSignUpConstans.passwordMin && passwordTextField.text?.count ?? 0 <= SecondSignUpConstans.passwordMax {
                self.startButton.backgroundColor = SecondSignUpConstans.startButtonEnableBackgroundColor
                self.startButton.isEnabled = true
                
            } else {
                self.startButton.backgroundColor = SecondSignUpConstans.startButtonDisableBackgroundColor
                self.startButton.isEnabled = false
            }
        }
        
        return true
    }
}

private extension SecondSignUpViewController {
    
    func settingTextFields() {
        super.setPaddingForTextField(nameTextField)
        super.setPaddingForTextField(usernameTextField)
        super.setPaddingForTextField(emailTextField)
        super.setPaddingForTextField(passwordTextField)
    }
    
    
    func setupSomeQuestionsLabel() {
        someQuestionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
        
        let range = (SecondSignUpConstans.mainStringSomeQuestionLabel as NSString).range(of: SecondSignUpConstans.signInText)
        let attributes = NSMutableAttributedString.init(string: SecondSignUpConstans.mainStringSomeQuestionLabel)
        attributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        someQuestionsLabel.attributedText = attributes
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        guard let dontHaveText = someQuestionsLabel.attributedText?.string else { return }
        
        if let range = dontHaveText.range(of: NSLocalizedString(SecondSignUpConstans.signInText, comment: "")),
            recognizer.didTapAttributedTextInLabel(label: someQuestionsLabel, inRange: NSRange(range, in: dontHaveText)) {
            self.performSegue(withIdentifier: SecondSignUpConstans.unwindSegueIdentifire, sender: self)
        }
    }
   
}
