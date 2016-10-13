//
//  VIPERPresenter.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

protocol IVIPERPresenter: class {

}

protocol IVIPERInterface: class {

    var presenter: IVIPERPresenter!  { get set }

}

class VIPERPresenter : IVIPERPresenter {

	weak private var view: IVIPERView!
	private let interactor: IVIPERInteractor
    private let wireframe: IVIPERWireFrame

    init(view: IVIPERView, interactor: IVIPERInteractor, wireframe: IVIPERWireFrame) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.interactor.presenter = self
    }
}


