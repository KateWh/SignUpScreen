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
    static let goToSignInSegueIdentifire = "goToSignIn"
}


class SecondSignUpViewController: BaseTextFieldViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
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
    
    @IBAction func unwindToSecondSignUp(segue: UIStoryboardSegue) {}
    
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
            self.performSegue(withIdentifier: SecondSignUpConstans.goToSignInSegueIdentifire, sender: self)
        }
    }
   
}
