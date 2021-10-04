//
//  DashViewModelTests.swift
//  MagaluGistTests
//
//  Created by Peter De Nardo on 04/10/21.
//

import XCTest
@testable import MagaluGist

//class DashBusinessTests: XCTestCase {
//    
//    func testHandleApiResult() {
//        if let data = (FileRepresentation(withFileName: "gistListExample", fileExtension: .json,fileBundle: Bundle(for: DashBusinessTests.self)).data) {
//            let apiResponse: DashApiResponse = { return (200, data)}
//            let business = DashBusiness()
//            
//            let expectation = XCTestExpectation(description: "Dash Business handling wiht api response")
//            expectation.assertForOverFulfill = true
//            business.handleResult(
//                response: apiResponse,
//                                 
//                completion: { result in
//                    do {
//                        let data = try result()
//                        XCTAssert(data.count == 15)
//                        XCTAssert(data[0].id == "07f93781c78d5b6da6a3dd8cd0519a9d")
//                        XCTAssert(data[7].id == "8f9d86803d067951a1b04dc49e0585e8")
//                        XCTAssert(data[14].id == "c5a44ca04c0384faca35385396f3164a")
//                        expectation.fulfill()
//                    } catch {
//                        assertionFailure()
//                    }
//                }
//            )
//            wait(for: [expectation], timeout: 15)
//            return
//        }
//    }
//}
