//
//  ToDoPresenter
//  GoJek
//
//  Editd by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ISignUpPresenter : class {
    func doInitialSetup()
    func emailFieldDone(text: String?)
    func passwordFieldDone(text: String?)
    func confirmPasswordFieldDone(text: String?)
    func signup()
    
    func signedUpUser(user: User)
    func failedToSignUpUser(error: NSError?)
}

class SignUpPresenter : ISignUpPresenter {
    weak var view:ISignUpView!
    let wireframe:ISignUpWireFrame
    var viewModel:SignUpViewModel
    let interceptor:ISignUpInterceptor
    
    init(view:ISignUpView,viewModel:SignUpViewModel, wireframe:ISignUpWireFrame, interceptor:ISignUpInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }
    
    func doInitialSetup() {
        view.hoookUpEvents()
        view.activateEmailField()
    }
    
    func emailFieldDone(text: String?) {
        viewModel.email = text
        if (text?.characters.count ?? 0) > 0 {
            view.activatePasswordField()
        }
    }
    
    func passwordFieldDone(text: String?) {
        viewModel.password = text
        if (text?.characters.count ?? 0) > 0 {
            view.activateConfirmPasswordField()
        }
    }
    
    func confirmPasswordFieldDone(text: String?) {
        viewModel.reenteredPassword = text
        if (text?.characters.count ?? 0) > 0 {
            signup()
        }
    }
    
    func signup() {
        view.dismissKeyboard()
        if viewModel.signingUp {
            return
        }
        
        guard let email = viewModel.email?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), password = viewModel.password?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), reenteredPassword = viewModel.reenteredPassword?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) else {
            view.showErrorMessage("Please enter all fields")
            return
        }
        
        guard email.characters.count > 0 else {
            view.showErrorMessage("Please enter a valid email address")
            return
        }
        guard password.characters.count > 6 else {
            view.showErrorMessage("Please enter a valid password (6 characters minimum)")
            return
        }
        guard password == reenteredPassword else {
            view.showErrorMessage("Passwords do not match")
            return
        }
        
        view.showLoading()
        viewModel.signingUp = true
        interceptor.signUpWithEmail(email, password: password)
    }
    
    func signedUpUser(user: User) {
        view.hideLoading()
        viewModel.signingUp = false
        wireframe.showHomeScreen()
    }
    
    func failedToSignUpUser(error: NSError?) {
        view.hideLoading()
        viewModel.signingUp = false
        view.showErrorMessage(error?.localizedDescription ?? "Cannot sign up")
    }
}