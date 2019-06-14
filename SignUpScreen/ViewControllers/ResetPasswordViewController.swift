//
//  ResetPasswordViewController.swift
//  SignUpScreen
//
//  Created by Ekaterina Romanchenko on 12/06/2019.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var someQuestionsLabel: UILabel!
    
    @IBOutlet weak var topConstraintSendButton: NSLayoutConstraint!
    @IBOutlet weak var topConstraintView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        setupSingInText()
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

private extension ResetPasswordViewController {
    
   func settingTextFields() {
    let spaceView = UIView(frame: CGRect(origin: ResetPasswordConstants.spacePointForTextFields, size: ResetPasswordConstants.spaceSizeForTextFields))
    
        emailTextField.leftViewMode = UITextField.ViewMode.always
        emailTextField.leftView = spaceView
    }
    
   func setupSingInText() {
    someQuestionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel)))
    
        let range = (ResetPasswordConstants.mainStringSomeQuestionLabel as NSString).range(of: ResetPasswordConstants.signInText)
        let attributes = NSMutableAttributedString.init(string: ResetPasswordConstants.mainStringSomeQuestionLabel)
        attributes.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        someQuestionsLabel.attributedText = attributes
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        guard let dontHaveText = someQuestionsLabel.attributedText?.string else { return }
        
        if let range = dontHaveText.range(of: NSLocalizedString(ResetPasswordConstants.signInText, comment: "")),
            recognizer.didTapAttributedTextInLabel(label: someQuestionsLabel, inRange: NSRange(range, in: dontHaveText)) {
            performSegue(withIdentifier: ResetPasswordConstants.goToSignInSegueIdentifire, sender: self)
        }
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrameSize = (userInfo [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // Save the distance which you want a use to raise the button.
        var interval = (keyboardFrameSize.minY - ResetPasswordConstants.tenPointers) - sendButton.frame.maxY
        
        // Check the ratio of the height of the button constraint to the height at which you want to raise the button.
        switch (topConstraintSendButton.constant - ResetPasswordConstants.threePointers) + interval {
        // If the constraint height larger, simply subtract the height of the decrease from it.
        case 0...:
            topConstraintSendButton.constant += interval
            topConstraintView.constant = ResetPasswordConstants.topViewConstraint
        // If the height of the decrease larger, subtract constraint height(without the minimum possible) from it, set minimum possible constraint height and subtract the remaining height of the decrease from the height of the view constraint.
        case ..<0:
            print("I", interval)
            interval += topConstraintSendButton.constant - ResetPasswordConstants.threePointers
            topConstraintSendButton.constant = ResetPasswordConstants.threePointers
            print("I", interval, "\nTop", topConstraintView.constant)
            topConstraintView.constant += interval
            print("Top after", topConstraintView.constant)
        default:
            break
        }
    }
    
    @objc func keyboardWillHide() {
        topConstraintSendButton.constant = ResetPasswordConstants.topSendButtonConstraint
        topConstraintView.constant = ResetPasswordConstants.topViewConstraint
    }
    
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * ResetPasswordConstants.fiftyPercent - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * ResetPasswordConstants.fiftyPercent - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

private struct ResetPasswordConstants {
    static let signInText = "Sign in"
    static let mainStringSomeQuestionLabel = "Do you remember your password? Sign in"
    static let goToSignInSegueIdentifire = "goToSignIn"
    static let spaceSizeForTextFields: CGSize = CGSize(width: 10, height: 10)
    static let spacePointForTextFields: CGPoint = CGPoint(x: 0, y: 0)
    static let threePointers: CGFloat = 3
    static let tenPointers: CGFloat = 10
    static let topViewConstraint: CGFloat = 72
    static let topSendButtonConstraint: CGFloat = 81
    static let fiftyPercent: CGFloat = 0.5
}
