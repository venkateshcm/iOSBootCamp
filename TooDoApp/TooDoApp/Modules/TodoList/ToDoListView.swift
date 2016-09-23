//
//  LocationPickerView.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit


protocol IToDoListView : class{
}

class ToDoListView : UIViewController, IToDoListView{
    var presenter:IToDoListPresenter!
    
    init(){
        super.init(nibName: "ToDoListView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}