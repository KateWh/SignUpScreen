//
//  SecondSignUpScreenViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SecondSignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    @IBOutlet weak var secondSignUpScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        setupSomeQuestionsLabel()
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
}

extension SecondSignUpViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = SecondSignUpConstans.borderWidth
        textField.layer.borderColor = SecondSignUpConstans.borderColor
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

private extension SecondSignUpViewController {
    
    func settingTextFields() {
        func setPaddingForTextField(_ textField: UITextField) {
            let spacerView = UIView(frame: CGRect(origin: SecondSignUpConstans.spacePointForTextFields, size: SecondSignUpConstans.spaceSizeForTextFields))
            
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = spacerView
        }
        
        setPaddingForTextField(nameTextField)
        setPaddingForTextField(usernameTextField)
        setPaddingForTextField(emailTextField)
        setPaddingForTextField(passwordTextField)
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
            performSegue(withIdentifier: SecondSignUpConstans.goToSignInSegueIdentifire, sender: self)
        }
    }

}

private struct SecondSignUpConstans {
    static let borderWidth: CGFloat = 2
    static let borderColor: CGColor = #colorLiteral(red: 0.499868989, green: 0.5142127275, blue: 0.5874249935, alpha: 1).cgColor
    static let mainStringSomeQuestionLabel = "Already have an account? Sign in"
    static let signInText = "Sign in"
    static let goToSignInSegueIdentifire = "goToSignIn"
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
}














