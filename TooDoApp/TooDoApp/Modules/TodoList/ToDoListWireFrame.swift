//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol IToDoListWireFrame {
    func presentListView(viewModel:ToDoListViewModel)
    func presentAddModule()
}


class ToDoListWireFrame : IToDoListWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentListView(viewModel:ToDoListViewModel){
        let view = appRouter.resolver.resolve(ToDoListView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func presentAddModule() {
        appRouter.presentModule(Module.CreateTodo, parameters: [:])
    }
        
}