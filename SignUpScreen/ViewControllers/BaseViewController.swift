//
//  BaseTextFieldViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 19/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

struct BaseConstants {
    static let borderWidth: CGFloat = 2
    static let borderColor: CGColor = #colorLiteral(red: 0.499868989, green: 0.5142127275, blue: 0.5874249935, alpha: 1).cgColor
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
    
    static let mainStringFont: UIFont? = UIFont(name: "Dax-Light", size: 15)
    static let subStringFont: UIFont? = UIFont(name: "Dax-Medium", size: 15)
    
    static let signUpText = "Sign up"
    static let signInText = "Sign in"
    
    static let tenPointers: CGFloat = 10
    static let threePointers: CGFloat = 3
    
    static let newPasswordScreenNextButtonTopConstraint: CGFloat = 58
    static let newPasswordScreenSubviewTopConstraint: CGFloat = 72
    
    static let resetPasswordScreenNextButtonTopConstraint: CGFloat = 81
    static let resetPasswordScreenSubviewTopConstraint: CGFloat = 72
    
    static let signInScreenMainStringSomeQuestionLabel = "Don't have an account? "
    static let signInScreenSignUpText = "Sign up"
    
    static let signUpScreenMainStringSomeQuestionLabel = "Already have an account? "
    static let signUpScreenSignInText = "Sign in"
    
    static let resetPasswordScreenMainStringSomeQuestionLabel = "Do you remember your password? "
    static let resetPasswordScreenSignInText = "Sign in"
    
    static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{6,168}")
}

enum BaseState {
    case newScreen(BaseConstants)
    case resetScreen(BaseConstants)
    case signInScreen(BaseConstants)
    case signUpScreen(BaseConstants)
    case none
}

class BaseViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var topConstraintNextButton: NSLayoutConstraint!
    @IBOutlet weak var topConstraintSubview: NSLayoutConstraint!
    
    var baseState = BaseState.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.registerKeyboardNotification()
        self.settingTextFields()
        self.setupSomeQuestionsLabel()
        
        if self is NewPasswordViewController {
            self.baseState = .newScreen(BaseConstants())
        } else if self is ResetPasswordViewController {
            self.baseState = .resetScreen(BaseConstants())
        } else if self is SignInViewController {
            self.baseState = .signInScreen(BaseConstants())
        } else if self is SignUpViewController {
            self.baseState = .signUpScreen(BaseConstants())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func makeGreyBorder(textField: UITextField) {
        textField.layer.borderWidth = BaseConstants.borderWidth
        textField.layer.borderColor = BaseConstants.borderColor
    }
    
    func hideBorder(textField: UITextField) {
        textField.layer.borderWidth = 0
    }
    
    func goToTheNext(textField: UITextField) -> Bool {
        guard let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField else { textField.resignFirstResponder()
            return true
        }
        nextField.becomeFirstResponder()
        return false
    }
    
    func setPaddingForTextField(_ textField: UITextField) {
        let spacerView = UIView(frame: CGRect(origin: BaseConstants.spacePointForTextFields, size: BaseConstants.spaceSizeForTextFields))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.layer.borderColor = BaseConstants.borderColor
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String?, massage: String?, preferredStyle: UIAlertController.Style, titleAction: String?, styleAction: UIAlertAction.Style, handlerAction: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: preferredStyle)
        let alertAction = UIAlertAction(title: titleAction, style: styleAction, handler: handlerAction)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion:  nil)
    }
    
    func makeTheSubstringOrange(label: UILabel, mainString: String, subStringForColoring: String, mainStringFont: UIFont? = BaseConstants.mainStringFont, subStringFont: UIFont? = BaseConstants.subStringFont ) {
        
        let mainAttributes = [NSAttributedString.Key.font : mainStringFont]
        let subAttributes = [NSAttributedString.Key.font : subStringFont]
        
        let stringAttributes = NSMutableAttributedString(string: mainString, attributes: mainAttributes as [NSAttributedString.Key : Any])
        let subStringAttributes = NSMutableAttributedString(string: subStringForColoring, attributes: subAttributes as [NSAttributedString.Key : Any])
        
        subStringAttributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: subStringForColoring.count))
        stringAttributes.append(subStringAttributes)
       label.attributedText = stringAttributes
        
    }
    
    func changePasswordView(_ textField: UITextField, button: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        button.isSelected = !button.isSelected
    }
    
    func setupSomeQuestionsLabel() {
        
        var mainString = ""
        var subString = ""
        
        if self is ResetPasswordViewController {
            mainString = BaseConstants.resetPasswordScreenMainStringSomeQuestionLabel
            subString = BaseConstants.resetPasswordScreenSignInText
        } else if self is SignInViewController {
            mainString = BaseConstants.signInScreenMainStringSomeQuestionLabel
            subString = BaseConstants.signInScreenSignUpText
        } else if self is SignUpViewController {
            mainString = BaseConstants.signUpScreenMainStringSomeQuestionLabel
            subString = BaseConstants.signUpScreenSignInText
        } else {
            return
        }
        
        self.makeTheSubstringOrange(label: self.someQuestionsLabel, mainString: mainString, subStringForColoring: subString)
        self.someQuestionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        guard let dontHaveText = someQuestionsLabel.attributedText?.string else { return }
        
        var text = BaseConstants.signInText
        if self is SignInViewController {
            text = BaseConstants.signUpText
        }
        if let range = dontHaveText.range(of: NSLocalizedString(text, comment: "")),
            recognizer.didTapAttributedTextInLabel(label: someQuestionsLabel, inRange: NSRange(range, in: dontHaveText)) {
            self.performToSegue()
        }
    }
    
    func performToSegue() {
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        var subviewTopConstraint: CGFloat = 0
        
        if self is NewPasswordViewController {
            subviewTopConstraint = BaseConstants.newPasswordScreenSubviewTopConstraint
        } else if self is ResetPasswordViewController {
            subviewTopConstraint = BaseConstants.newPasswordScreenSubviewTopConstraint
        } else {
            return
        }
        
        guard let userInfo = notification.userInfo, let keyboardFrameSize = (userInfo [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
    
        var interval = (keyboardFrameSize.minY - BaseConstants.tenPointers) - nextButton.frame.maxY
        guard interval < 0 else { return }
        // Check the ratio of the height of the button constraint to the height at which you want to raise the button.
        switch (topConstraintNextButton.constant - BaseConstants.threePointers) + interval {
        // If the constraint height larger, simply subtract the height of the decrease from it.
        case 0...:
            topConstraintNextButton.constant += interval
            topConstraintSubview.constant = subviewTopConstraint
        // If the height of the decrease larger, subtract constraint height(without the minimum possible) from it, set minimum possible constraint height and subtract the remaining height of the decrease from the height of the view constraint.
        case ..<0:
            interval += topConstraintNextButton.constant - BaseConstants.threePointers
            topConstraintNextButton.constant = BaseConstants.threePointers
            topConstraintSubview.constant += interval
        default:
            break
        }
    }
    
    @objc func keyboardWillHide() {
        var nextButtonTopConstraint: CGFloat = 0
        var subviewTopConstraint: CGFloat = 0
        
        if self is NewPasswordViewController {
            nextButtonTopConstraint = BaseConstants.newPasswordScreenNextButtonTopConstraint
            subviewTopConstraint = BaseConstants.newPasswordScreenSubviewTopConstraint
        } else if self is ResetPasswordViewController {
            nextButtonTopConstraint = BaseConstants.resetPasswordScreenNextButtonTopConstraint
            subviewTopConstraint = BaseConstants.newPasswordScreenSubviewTopConstraint
        } else {
            return
        }
        
        topConstraintNextButton.constant = nextButtonTopConstraint
        topConstraintSubview.constant = subviewTopConstraint
    }
    
    func settingTextFields() {
    }
    
}

