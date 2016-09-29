//
//  ToDoPresenter
//  GoJek
//
//  Editd by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ILoginPresenter : class {
    func doInitialSetup()
    func emailFieldDone(text: String?)
    func passwordFieldDone(text: String?)
    func login()
    
    func loggedInUser(user: User)
    func failedToLoginUser(error: NSError?)
}

class LoginPresenter : ILoginPresenter {
    weak var view:ILoginView!
    let wireframe:ILoginWireFrame
    var viewModel:LoginViewModel
    let interceptor:ILoginInterceptor
    
    init(view:ILoginView,viewModel:LoginViewModel, wireframe:ILoginWireFrame, interceptor:ILoginInterceptor){
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
            login()
        }
    }
    
    func login() {
        view.dismissKeyboard()
        if viewModel.loggingIn {
            return
        }
        
        guard let email = viewModel.email?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()), password = viewModel.password?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) else {
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
        
        view.showLoading()
        viewModel.loggingIn = true
        interceptor.loginWithEmail(email, password: password)
    }
    
    func loggedInUser(user: User) {
        view.hideLoading()
        viewModel.loggingIn = false
        wireframe.showHomeScreen()
    }
    
    func failedToLoginUser(error: NSError?) {
        view.hideLoading()
        viewModel.loggingIn = false
        view.showErrorMessage(error?.localizedDescription ?? "Cannot login")
    }
}