//
//  APIUnitTests.swift
//  UnitTests
//
//  Created by Darya Kuliashova on 11/21/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import XCTest
import Alamofire

@testable import TurkcellTechnicalAssignment

class APIUnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testThatResponseJSONReturnsSuccessResultWithValidJSON() {
        let expect = expectation(description: "Valid JSON Received")
        let productAPIClient = ProductAPIClient()
        var response: [Product]?
        var responseError: Error?
        
        productAPIClient.fetchAllProductsInfo { result in
            switch result {
            case .success(let product):
                response = product
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
        
        XCTAssertNotNil(response)
        XCTAssertNil(responseError)
    }
    
    func testThatAmountOfElementsInResponseIsEqualToTwelve() {
        let expect = expectation(description: "12 products received")
        let productAPIClient = ProductAPIClient()
        var response: [Product]?
        var responseError: Error?
        
        productAPIClient.fetchAllProductsInfo { result in
            switch result {
            case .success(let product):
                response = product
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 12)
        XCTAssertNil(responseError)
    }
    
    func testThatResponseReturnsCorrectProductByProductID() {
        let expect = expectation(description: "Chicken has successfully received with product id 7")
        let productAPIClient = ProductAPIClient()
        let productID = "7"
        var response: Product?
        var responseError: Error?
        
        productAPIClient.fetchProductDetails(productID: productID) { result in
            switch result {
            case .success(let product):
                response = product
            case .failure(let error):
                responseError = error
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
        
        XCTAssertEqual(response?.product_id, "7")
        XCTAssertEqual(response?.name, "Chicken")
        XCTAssertEqual(response?.description, "Chicken, the other white meat.")
        XCTAssertNotNil(response)
        XCTAssertNil(responseError)
    }
}
