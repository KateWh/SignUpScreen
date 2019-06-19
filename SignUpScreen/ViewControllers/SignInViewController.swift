//
//  SignInViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignInConstans {
    static let mainStringSomeQuestionLabel = "Don't have an account? Sign up"
    static let signUpText = "Sign up"
    static let goToSignUpSegueIdentifire = "goToSignUp"
}


class SignInViewController: BaseTextFieldViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!

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

private extension SignInViewController {
    
    func settingTextFields() {
        super.setPaddingForTextField(emailTextField)
        super.setPaddingForTextField(passwordTextField)
    }
    
    func setupSomeQuestionsLabel() {
        someQuestionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
        
        let range = (SignInConstans.mainStringSomeQuestionLabel as NSString).range(of: SignInConstans.signUpText)
        let attributes = NSMutableAttributedString.init(string: SignInConstans.mainStringSomeQuestionLabel)
        attributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        someQuestionsLabel.attributedText = attributes
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        guard let dontHaveText = someQuestionsLabel.attributedText?.string else { return }
        
        if let range = dontHaveText.range(of: NSLocalizedString(SignInConstans.signUpText, comment: "")),
            recognizer.didTapAttributedTextInLabel(label: someQuestionsLabel, inRange: NSRange(range, in: dontHaveText)) {
           performSegue(withIdentifier: "unwindSegueToSecondSignUp", sender: self)
        }
    }
    
}
