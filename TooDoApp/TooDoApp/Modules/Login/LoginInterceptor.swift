//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ILoginInterceptor  : class {
    var presenter : ILoginPresenter? {get set}
    func loginWithEmail(email: String, password: String)
}

class LoginInterceptor : ILoginInterceptor {
    weak var _presenter: ILoginPresenter?
    var service: ITodoService
    
    var presenter : ILoginPresenter? {
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init(service: ITodoService) {
        self.service = service
    }
    
    func loginWithEmail(email: String, password: String) {
        service.loginWithEmail(email, password: password, success: {[weak self] (response) in
            guard let user = response?.user else {
                self?.presenter?.failedToLoginUser(response?.error?.nsError)
                return
            }
            self?.presenter?.loggedInUser(user)
            
            }) {[weak self] (response, data, error) in
                self?.presenter?.failedToLoginUser(error)
        }
    }
}
