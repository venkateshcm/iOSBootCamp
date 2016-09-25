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
    func showLoading()
    func hideLoading()
    func redisplayTodos()
    func showErrorMessage(message: String)
    func hoookUpEvents()
}

class ToDoListView : UIViewController, IToDoListView, UITableViewDataSource, UITableViewDelegate {
    var presenter:IToDoListPresenter!
    
    @IBOutlet weak var tableView: UITableView?
    private let cellIdentifier = "TodoCellIdentifier"
    
    init(){
        super.init(nibName: "ToDoListView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Todo List"
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        presenter.doInitialSetup()
    }
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getTodos()
    }
    
    // MARK: Actions
    
    func touchRefresh() {
        presenter.refreshButtonPressed()
    }
    
    func touchAdd() {
        presenter.addButtonPressed()
    }
    
    // MARK: ITodoListView methods
    
    func hoookUpEvents() {
        let refreshButton = UIBarButtonItem.init(barButtonSystemItem: .Refresh, target: self, action: #selector(ToDoListView.touchRefresh))
        navigationItem.leftBarButtonItem = refreshButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ToDoListView.touchAdd))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
    func redisplayTodos() {
        tableView?.reloadData()
    }
    
    func showErrorMessage(message: String) {
        showErrorAlertWithMessage(message, title: "")
    }
    
    // MARK: UITableViewDataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTodos
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = presenter.todoItemDescriptionAtIndex(indexPath.row)
        return cell
    }
}