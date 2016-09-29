//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol ILoginWireFrame {
    func presentView(viewModel:LoginViewModel)
    func goBack()
    func showHomeScreen()
}


class LoginWireFrame : ILoginWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:LoginViewModel){
        let view = appRouter.resolver.resolve(LoginView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func goBack() {
        appRouter.dismissViewFromNavigationController(true, completion: {})
    }
    
    func showHomeScreen() {
        appRouter.presentModule(Module.ToDoList, parameters: [:])
    }
}