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
}

class BaseViewController: UIViewController {
    
   @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.registerKeyboardNotification()
        self.settingTextFields()
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
    }
    
    @objc func keyboardWillHide() {
    }
    
    func settingTextFields() {
    }
    
}

