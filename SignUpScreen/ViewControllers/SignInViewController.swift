//
//  SignInViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        setupSomeQuestionsLabel()
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        print("PASSWORD BUTTON")
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = SignInConstans.borderWidth
        textField.layer.borderColor = SignInConstans.borderColor
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
}

private extension SignInViewController {
    
    func settingTextFields() {
        func setPaddingForTextField(_ textField: UITextField) {
            let spacerView = UIView(frame: CGRect(origin: SignInConstans.spacePointForTextFields, size: SignInConstans.spaceSizeForTextFields))
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = spacerView
        }
        
        setPaddingForTextField(emailTextField)
        setPaddingForTextField(passwordTextField)
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
            performSegue(withIdentifier: SignInConstans.goToSignUpSegueIdentifire, sender: self)
        }
    }
    
}

private struct SignInConstans {
    static let borderWidth: CGFloat = 2
    static let borderColor: CGColor = #colorLiteral(red: 0.499868989, green: 0.5142127275, blue: 0.5874249935, alpha: 1).cgColor
    static let mainStringSomeQuestionLabel = "Don't have an account? Sign up"
    static let signUpText = "Sign up"
    static let goToSignUpSegueIdentifire = "goToSignUp"
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
}
