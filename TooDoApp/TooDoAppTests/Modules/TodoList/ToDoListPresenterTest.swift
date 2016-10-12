//
//  ToDoListPresenterTest.swift
//  TooDoApp
//
//  Created by admin on 12/10/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import TooDoApp

class ToDoListPresenterTest: QuickSpec {

    override func spec() {
        let viewModel = ToDoListViewModel()
        let viewMock = ToDoListViewMock()
        let wireFrameMock = ToDoListWireFrameMock()
        let interceptorMock = ToDoListInterceptorMock()
        var presenter: ToDoListPresenter!
        
        beforeEach{
            viewMock.resetMock()
            wireFrameMock.resetMock()
            interceptorMock.resetMock()
            presenter = ToDoListPresenter(view: viewMock, viewModel: viewModel, wireframe: wireFrameMock, interceptor: interceptorMock)
            interceptorMock.presenter = presenter
            
        }
        
        // do initial setup
        describe("Presenter Loading View and updating View Actions") {
            it("doInitialSetup should hookup view events") {
                presenter.doInitialSetup()
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("hoookUpEvents()"))
                expect(interceptorMock.invocations.count) == 0
            }

            it("get Todos should get list of Todos from Interceptor") {
                presenter.getTodos()
                
                expect(viewMock.invocations.count) == 3
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 1
                expect(interceptorMock.invocations).to(contain("getTodos()"))
                
                expect(viewModel.todos?.count) == 2
                
            }
            
            it("refresh Button should refresh list of Todos from Interceptor") {
                presenter.refreshButtonPressed()
                
                expect(viewMock.invocations.count) == 3
                expect(viewMock.invocations).to(contain("showLoading()"))
                expect(viewMock.invocations).to(contain("hideLoading()"))
                expect(viewMock.invocations).to(contain("redisplayTodos()"))
                expect(interceptorMock.invocations.count) == 1
                expect(interceptorMock.invocations).to(contain("getTodos()"))
                
                expect(viewModel.todos?.count) == 2
                
            }

        }
        
        describe("Presenter Navigation Actions") {
            it("addButtonPressed should take call wireframe to navigate to Add Todo Screen") {
                presenter.addButtonPressed()
                
                expect(wireFrameMock.invocations.count) == 1
                expect(wireFrameMock.invocations).to(contain("presentAddModule()"))
            }
        }

        
        
    }

}