//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ISignUpInterceptor  : class {
    var presenter : ISignUpPresenter? {get set}
    func signUpWithEmail(email: String, password: String)
}

class SignUpInterceptor : ISignUpInterceptor {
    weak var _presenter: ISignUpPresenter?
    var service: ITodoService
    
    var presenter : ISignUpPresenter? {
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init(service: ITodoService) {
        self.service = service
    }
    
    func signUpWithEmail(email: String, password: String) {
        service.signUpWithEmail(email, password: password, success: {[weak self] (response) in
            guard let user = response?.user else {
                self?.presenter?.failedToSignUpUser(response?.error?.nsError)
                return
            }
            self?.presenter?.signedUpUser(user)
            
            }) {[weak self] (response, data, error) in
                self?.presenter?.failedToSignUpUser(error)
        }
    }
}
