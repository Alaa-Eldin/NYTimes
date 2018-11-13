//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Alaa Eldin on 11/11/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {

    var testingSession: URLSession!

    override func setUp() {
        testingSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testingSession = nil
    }

    func testValidCallToNYTimesMostPopularGetsHTTPStatusCode200() {
        //Moking the full url with correct key
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=e9b112eac69f44329a66227e25d48cf6")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = testingSession.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSectionsExistWithMinijmumOneSectionAvailable(){
        let sections = NewsFeedSectionsManager().newsFeedSections
        XCTAssertNotNil(sections)
        if let sections = sections {
            XCTAssertTrue(sections.count > 0)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
