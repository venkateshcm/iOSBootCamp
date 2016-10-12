//
//  LoginAssembly.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class LoginAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(ILoginInterceptor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return LoginInterceptor(service: service)
        }
        
        container.register(ILoginWireFrame.self) { (r, appRouter: IAppRouter) in
            LoginWireFrame(appRouter: appRouter)
        }
        
        container.register(ILoginPresenter.self) { (r, view: ILoginView, viewModel:LoginViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(ILoginInterceptor.self)!
            let wireframe = r.resolve(ILoginWireFrame.self, argument: appRouter)!
            let presenter = LoginPresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(LoginView.self) {  (r, appRouter: IAppRouter, viewModel:LoginViewModel) in
            let view = LoginView()
            let presenter = r.resolve(ILoginPresenter.self, arguments: (view as ILoginView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}