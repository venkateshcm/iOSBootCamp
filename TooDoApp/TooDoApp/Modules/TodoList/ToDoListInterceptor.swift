//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IToDoListInterceptor  : class {
    var presenter : IToDoListPresenter? {get set }
}


class ToDoListInterceptor : IToDoListInterceptor{
    weak var _presenter: IToDoListPresenter?
    
    var presenter : IToDoListPresenter?{
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init()
    {
    }
    
}
