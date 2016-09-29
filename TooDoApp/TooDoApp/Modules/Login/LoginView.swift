//
//  LocationPickerView.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit


protocol ILoginView : class{
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
    func hoookUpEvents()
    func activateEmailField()
    func activatePasswordField()
    func dismissKeyboard()
}

class LoginView : UIViewController, ILoginView, UITextFieldDelegate {
    var presenter:ILoginPresenter!
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    
    init(){
        super.init(nibName: "LoginView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Login"
        presenter.doInitialSetup()
    }
    
    // MARK: Actions
    
    func touchDone() {
        presenter.login()
    }
    
    func emailFieldDone() {
        presenter.emailFieldDone(emailField?.text)
    }
    
    func passwordFieldDone() {
        presenter.passwordFieldDone(passwordField?.text)
    }
    
    // MARK: ITodoListView methods
    
    func hoookUpEvents() {
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .Done, target: self, action: #selector(LoginView.touchDone))
        navigationItem.rightBarButtonItem = doneButton
        
        emailField?.addTarget(self, action: #selector(LoginView.emailFieldDone), forControlEvents: .EditingDidEndOnExit)
        passwordField?.addTarget(self, action: #selector(LoginView.passwordFieldDone), forControlEvents: .EditingDidEndOnExit)
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == emailField {
            presenter.emailFieldDone(emailField?.text)
        } else if textField == passwordField {
            presenter.passwordFieldDone(passwordField?.text)
        }
    }
}