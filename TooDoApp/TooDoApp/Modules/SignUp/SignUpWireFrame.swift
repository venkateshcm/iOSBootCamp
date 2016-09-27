//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol ISignUpWireFrame {
    func presentView(viewModel:SignUpViewModel)
    func goBack()
    func showHomeScreen()
}


class SignUpWireFrame : ISignUpWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:SignUpViewModel){
        let view = appRouter.resolver.resolve(SignUpView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func goBack() {
        appRouter.dismissViewFromNavigationController(true, completion: {})
    }
    
    func showHomeScreen() {
        appRouter.presentModule(Module.ToDoList, parameters: [:])
    }
}