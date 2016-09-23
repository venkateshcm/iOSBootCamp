//
//  ToDoPresenter
//  GoJek
//
//  Created by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IToDoListPresenter : class {
}

class ToDoListPresenter : IToDoListPresenter {
    weak var view:IToDoListView!
    let wireframe:IToDoListWireFrame
    let viewModel:ToDoListViewModel
    let interceptor:IToDoListInterceptor
    
    init(view:IToDoListView,viewModel:ToDoListViewModel, wireframe:IToDoListWireFrame, interceptor:IToDoListInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }

}