//
//  ToDoPresenter
//  GoJek
//
//  Created by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IToDoListPresenter : class {
    func getTodos()
    func gotTodos(todos: [TodoItem])
    func failedToGetTodos(error: NSError?)
    var numberOfTodos: Int {get}
    func todoItemDescriptionAtIndex(index: Int) -> String
    func doInitialSetup()
    func addButtonPressed()
    func refreshButtonPressed()
    func selectedItemAtIndex(index: Int)
}

class ToDoListPresenter : IToDoListPresenter {
    weak var view:IToDoListView!
    let wireframe:IToDoListWireFrame
    var viewModel:ToDoListViewModel
    let interceptor:IToDoListInterceptor
    
    init(view:IToDoListView,viewModel:ToDoListViewModel, wireframe:IToDoListWireFrame, interceptor:IToDoListInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }
    
    func doInitialSetup() {
        view.hoookUpEvents()
    }
    
    func getTodos() {
        view.showLoading()
        interceptor.getTodos()
    }
    
    func refreshButtonPressed() {
        getTodos()
    }
    
    func addButtonPressed() {
        wireframe.presentAddModule()
    }
    
    func selectedItemAtIndex(index: Int) {
        guard let items = viewModel.todos where items.count > index else {
            return
        }
        let todo = items[index]
        wireframe.presentEditModule(todo)
    }
    
    func gotTodos(todos: [TodoItem]) {
        view.hideLoading()
        viewModel.todos = todos
        view.redisplayTodos()
    }
    
    func failedToGetTodos(error: NSError?) {
        view.hideLoading()
        view.showErrorMessage(error?.localizedDescription ?? "There was a problem while fetching todos")
    }
    
    var numberOfTodos: Int {
        return viewModel.todos?.count ?? 0
    }
    
    func todoItemDescriptionAtIndex(index: Int) -> String {
        guard let todos = viewModel.todos where todos.count > index else {
            return ""
        }
        return todos[index].description ?? ""
    }

}