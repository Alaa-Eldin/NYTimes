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
    var newsWireFrame: NewsFeedWireframe!
    override func setUp() {
        testingSession = URLSession(configuration: URLSessionConfiguration.default)
        newsWireFrame = NewsFeedWireframe()
        newsWireFrame.moduleView.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testingSession = nil
    }

    func testValidCallToNYTimesMostPopularGetsHTTPStatusCode200() {
        //Moking the full url with correct key
        let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/"
        let url = URL(string: "\(baseURL)7.json?api-key=e9b112eac69f44329a66227e25d48cf6")
        // 1
        let promise = expectation(description: "Status code: 200")
        // when
        let dataTask = testingSession.dataTask(with: url!) { _, response, error in
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
    func testSectionsExistWithMinijmumOneSectionAvailable() {
        let sections = NewsFeedSectionsManager().newsFeedSections
        XCTAssertNotNil(sections)
        if let sections = sections {
            XCTAssertTrue(sections.count > 0)
        }
    }
    func testTableViewIsInNewsViewController() {
        newsWireFrame.moduleView.loadViewIfNeeded()
        XCTAssertNotNil(newsWireFrame.moduleView.newsTableView,
                        "Controller should have a news tableview")
    }
    func testNewsTableViewCellsCount() {
        let news = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                identifier: 3000, abstract: "that was a great news to announce", media: nil)
        let news1 = NewsFeedData(title: "Great title 1", publishedDate: "11/10/2019",
                                 identifier: 3001, abstract: "that was a great news to announce", media: nil)
        let news2 = NewsFeedData(title: "Great title 2", publishedDate: "12/10/2019",
                                 identifier: 3002, abstract: "that was a great news to announce 2", media: nil)
        let news3 = NewsFeedData(title: "Great title 3", publishedDate: "13/10/2019",
                                 identifier: 3003, abstract: "that was a great news to announce 3", media: nil)
        let news4 = NewsFeedData(title: "Great title 4", publishedDate: "14/10/2019",
                                 identifier: 3004, abstract: "that was a great news to announce 4", media: nil)
        let newsTableView = newsWireFrame.moduleView.newsTableView
        newsTableView?.dataSource = newsWireFrame.moduleView
        newsWireFrame.moduleView.newsFeedsData = [news, news1, news2, news3, news4]
        let numberOfRows = newsWireFrame.moduleView.tableView(newsTableView!, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 5,
                       "Number of rows in table should match number of given news which is 5")
    }
    func testNewsTableViewCells() {
        let news = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                identifier: 3000, abstract: "that was a great news to announce", media: nil)
        let news1 = NewsFeedData(title: "Great title 1", publishedDate: "11/10/2019",
                                 identifier: 3001, abstract: "that was a great news to announce", media: nil)
        let news2 = NewsFeedData(title: "Great title 2", publishedDate: "12/10/2019",
                                 identifier: 3002, abstract: "that was a great news to announce 2", media: nil)
        let news3 = NewsFeedData(title: "Great title 3", publishedDate: "13/10/2019",
                                 identifier: 3003, abstract: "that was a great news to announce 3", media: nil)
        let news4 = NewsFeedData(title: "Great title 4", publishedDate: "14/10/2019",
                                 identifier: 3004, abstract: "that was a great news to announce 4", media: nil)
        let newsTableView = newsWireFrame.moduleView.newsTableView
        newsTableView?.dataSource = newsWireFrame.moduleView
        newsWireFrame.moduleView.newsFeedsData = [news, news1, news2, news3, news4]
        newsWireFrame.moduleView.showMostPopularNews(newsFeedData: newsWireFrame.moduleView.newsFeedsData)
        let firstRow = newsWireFrame.moduleView.tableView(newsTableView!, cellForRowAt:
            IndexPath(row: 0, section: 0)) as? NewsFeedCell
        XCTAssertEqual(firstRow?.dateLabel.text, "10/10/2019",
                       "shown Date at the first row should be as the expected 10/10/2019")
    }
}
