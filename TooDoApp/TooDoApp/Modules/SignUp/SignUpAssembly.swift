//
//  SignUpAssembly.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class SignUpAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(ISignUpInterceptor.self) { r in
            return SignUpInterceptor(service: TodoService(authManager: AuthManager.sharedManager))
        }
        
        container.register(ISignUpWireFrame.self) { (r, appRouter: IAppRouter) in
            SignUpWireFrame(appRouter: appRouter)
        }
        
        container.register(ISignUpPresenter.self) { (r, view: ISignUpView, viewModel:SignUpViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(ISignUpInterceptor.self)!
            let wireframe = r.resolve(ISignUpWireFrame.self, argument: appRouter)!
            let presenter = SignUpPresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(SignUpView.self) {  (r, appRouter: IAppRouter, viewModel:SignUpViewModel) in
            let view = SignUpView()
            let presenter = r.resolve(ISignUpPresenter.self, arguments: (view as ISignUpView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}