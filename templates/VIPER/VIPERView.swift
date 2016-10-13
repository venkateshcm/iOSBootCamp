//
//  VIPERView.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

import UIKit

protocol IVIPERView : class {

}

class VIPERView: UIViewController, IVIPERView {

	var presenter: IVIPERPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
    }

}
