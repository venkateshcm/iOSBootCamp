//
//  VIPERWireFrame.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//


protocol IVIPERWireFrame: class {

}


class VIPERWireFrame: IVIPERWireFrame {

    let parentRouter: IAppRouter

    init(parentRouter: IAppRouter) {
        self.parentRouter = parentRouter
    }

}