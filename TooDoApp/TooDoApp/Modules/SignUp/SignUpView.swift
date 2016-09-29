//
//  LocationPickerView.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit


protocol ISignUpView : class{
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
    func hoookUpEvents()
    func activateEmailField()
    func activatePasswordField()
    func activateConfirmPasswordField()
    func dismissKeyboard()
}

class SignUpView : UIViewController, ISignUpView, UITextFieldDelegate {
    var presenter:ISignUpPresenter!
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var confirmPasswordField: UITextField?
    
    init(){
        super.init(nibName: "SignUpView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Sign Up"
        presenter.doInitialSetup()
    }
    
    // MARK: Actions
    
    func touchDone() {
        presenter.signup()
    }
    
    func emailFieldDone() {
        presenter.emailFieldDone(emailField?.text)
    }
    
    func passwordFieldDone() {
        presenter.passwordFieldDone(passwordField?.text)
    }
    
    func confirmPasswordFieldDone() {
        presenter.confirmPasswordFieldDone(confirmPasswordField?.text)
    }
    
    
    // MARK: ITodoListView methods
    
    func hoookUpEvents() {
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .Done, target: self, action: #selector(SignUpView.touchDone))
        navigationItem.rightBarButtonItem = doneButton
        
        emailField?.addTarget(self, action: #selector(SignUpView.emailFieldDone), forControlEvents: .EditingDidEndOnExit)
        passwordField?.addTarget(self, action: #selector(SignUpView.passwordFieldDone), forControlEvents: .EditingDidEndOnExit)
        confirmPasswordField?.addTarget(self, action: #selector(SignUpView.confirmPasswordFieldDone), forControlEvents: .EditingDidEndOnExit)
        emailField?.becomeFirstResponder()
    }
    
    func showLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func showErrorMessage(message: String) {
        showErrorAlertWithMessage(message, title: "")
    }
    
    func activateEmailField() {
        emailField?.becomeFirstResponder()
    }
    
    func activatePasswordField() {
        passwordField?.becomeFirstResponder()
    }
    
    func activateConfirmPasswordField() {
        confirmPasswordField?.becomeFirstResponder()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == emailField {
            presenter.emailFieldDone(emailField?.text)
        } else if textField == passwordField {
            presenter.passwordFieldDone(passwordField?.text)
        } else if textField == confirmPasswordField {
            presenter.confirmPasswordFieldDone(confirmPasswordField?.text)
        }
        
    }
}