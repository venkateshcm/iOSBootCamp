//
//  VIPERPresenterIntegrationTests.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//


import Foundation
import Nimble
import Quick
import OHHTTPStubs

class HomePresenterIntegrationTests: QuickSpec {
    var presenter:IHomePresenter!
    var viewModel:VIPERViewModel = VIPERViewModel()
    override func spec(){
        beforeEach {
            let appRouter = AppRouterMock.createAppRouter([PRODUCTCommonAssembly(),VIPERAssembly()])
            self.presenter = appRouter.resolver.resolve(IVIPERPresenter.self, arguments: (nil ,viewModel:viewModel,appRouter:appRouter))!

        }

        afterEach {
            OHHTTPStubs.removeAllStubs()
        }

        describe("Presenter should setUp the view after viewdidLoad()"){
            it("presenter ......") {
                let expectation = self.expectationWithDescription("Query timed out.");

                //if
                stub(isPath("<<PATH TO >>")){ _ in
                    let returnValue = OHHTTPStubsResponse(fileAtPath:OHPathForFile("<<<FILENAME>>>.json", self.dynamicType)!,
                                                          statusCode:200, headers:["Content-Type":"application/json"])
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        expectation.fulfill()
                    }
                    return returnValue
                }

                //when
                self.presenter.setupView()

                //then
                self.waitForExpectationsWithTimeout(10){ error in
                    expect(error).to(beNil())
                }
            }
        }
    }
}
