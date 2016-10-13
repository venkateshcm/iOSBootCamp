//
//  VIPERAssembly.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

import Foundation
import Swinject

class VIPERAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(IVIPERInteractor.self) { _ in
            VIPERInteractor()
        }

        container.register(IVIPERWireFrame.self) { (r, parentRouter: IAppRouter) in
            VIPERWireFrame(parentRouter: parentRouter)
        }

        container.register(IVIPERPresenter.self) { (r, view: IVIPERView, parentRouter: IAppRouter) in
            let interactor = r.resolve(IVIPERInteractor.self)!
            let wireframe = r.resolve(IVIPERWireFrame.self, argument: parentRouter)!
            return VIPERPresenter(view: view, interactor: interactor, wireframe: wireframe)
        }

        container.register(IVIPERView.self) {  (r, parentRouter: IAppRouter) in
            let view = VIPERView()
            let presenter = r.resolve(IVIPERPresenter.self, arguments: (view as IVIPERView, parentRouter))!
            view.presenter = presenter

            return view
        }

    }

}