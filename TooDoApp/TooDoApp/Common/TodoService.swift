//
//  TodoService.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Alamofire

protocol IAuthManager {
    mutating func saveToken(token: String)
    var authHeaders: [String : String] {get}
}

struct AuthManager: IAuthManager {
    static let sharedManager = AuthManager()
    private (set) var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySUQiOiI1N2U2YjI2MmYyMjE2ZGVlZjg0Y2YwOTQiLCJjcmVhdGVkIjoiMjAxNi0wOS0yNVQxMzowOToxMC4yNjBaIn0.XSkxypx6_DQhUyV62YZopQdDJRMzJZz5U_1W6M_z96g"
    
    mutating func saveToken(token: String) {
        self.token = token
    }
    
    var authHeaders: [String : String] {
        return ["Authorization" : "Bearer " + token]
    }
}

typealias NetworkFailureHandler = (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void

let BASE_URL = "http://localhost:4000"

protocol ITodoService {
    func getTodos(success: (GetTodosResponse?) -> Void, failure: NetworkFailureHandler)
    func createTodo(description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler)
    func updateTodoWithID(todoID: String, description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler)
    func deleteTodoWithID(todoID: String, success: (DeleteTodoResponse?) -> Void, failure: NetworkFailureHandler)
}

struct TodoService: ITodoService {
    private let authManager: IAuthManager
    
    init(authManager: IAuthManager) {
        self.authManager = authManager
    }
    
    func getTodos(success: (GetTodosResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos"
        Alamofire.request(.GET, url, headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(GetTodosResponse(JSONString: jsonString))
        }
        
    }
    
    func createTodo(description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/create"
        Alamofire.request(.POST, url, parameters: ["description" : description], headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(CreateTodoResponse(JSONString: jsonString))
        }
    }
    
    func updateTodoWithID(todoID: String, description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/" + todoID
        Alamofire.request(.PUT, url, parameters: ["description" : description], headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(CreateTodoResponse(JSONString: jsonString))
        }
    }
    
    func deleteTodoWithID(todoID: String, success: (DeleteTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/" + todoID
        Alamofire.request(.DELETE, url, headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(DeleteTodoResponse(JSONString: jsonString))
        }
    }
}
