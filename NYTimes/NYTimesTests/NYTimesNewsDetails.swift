//
//  NYTimesNewsDetails.swift
//  NYTimesTests
//
//  Created by Alaa Eldin on 11/24/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesNewsDetails: XCTestCase {
    var newsDetailsWireframe: NewsDetailsWireframe!
    override func setUp() {
    }
    func testFullNewsShownSuccessfully() {
        let metaData = NewsFeedMediaInfo(url:
            "https://static01.nyt.com/images/2018/11/24/world/24andaman-2-print/24indiamurder1-jumbo.jpg",
                                         format: "Jumbo", height: 683, width: 1024)
        let media = NewsFeedMedia(type: "image", metadata: [metaData])
        let newsInfo = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                identifier: 3000, abstract: "that was a great news to announce", media: [media])
        newsDetailsWireframe = NewsDetailsWireframe(newsFeedInfo: newsInfo)
        let view = newsDetailsWireframe.moduleView
        view.loadViewIfNeeded()
        XCTAssertEqual(view.newsDetailsTextView.text,
                       newsInfo.abstract, "News text field should show given news info abstract")
    }
    func testNoNewsShouldBeShown() {
        let metaData = NewsFeedMediaInfo(url:
            "https://static01.nyt.com/images/2018/11/24/world/24andaman-2-print/24indiamurder1-jumbo.jpg",
                                         format: "Jumbo", height: 683, width: 1024)
        let media = NewsFeedMedia(type: "image", metadata: [metaData])
        let newsInfo = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                    identifier: 3000, abstract: "that was a great news to announce", media: [media])
        newsDetailsWireframe = NewsDetailsWireframe(newsFeedInfo: newsInfo)
        newsDetailsWireframe.modulePresenter.newsFeedInfo = nil
        let view = newsDetailsWireframe.moduleView
        view.loadViewIfNeeded()
        XCTAssertEqual(view.newsDetailsTextView.text, "", "News text field should show nothing when there is no news")
    }
    func testModuleWireFrameIsConstructed() {
        let metaData = NewsFeedMediaInfo(url:
            "https://static01.nyt.com/images/2018/11/24/world/24andaman-2-print/24indiamurder1-jumbo.jpg",
                                         format: "Jumbo", height: 683, width: 1024)
        let media = NewsFeedMedia(type: "image", metadata: [metaData])
        let newsInfo = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                    identifier: 3000, abstract: "that was a great news to announce", media: [media])
        newsDetailsWireframe = NewsDetailsWireframe(newsFeedInfo: newsInfo)
        XCTAssertNotNil(newsDetailsWireframe.modulePresenter.moduleWireframe,
                        "Module wireframe should have a non nil reference in presenter")
    }
    func testModulJumboImageIsShownSuccessfully() {
        let metaData = NewsFeedMediaInfo(url:
            "https://static01.nyt.com/images/2018/11/24/world/24andaman-2-print/24indiamurder1-jumbo.jpg",
                                         format: "Jumbo", height: 683, width: 1024)
        let media = NewsFeedMedia(type: "image", metadata: [metaData])
        let newsInfo = NewsFeedData(title: "Great title", publishedDate: "10/10/2019",
                                    identifier: 3000, abstract: "that was a great news to announce", media: [media])
        newsDetailsWireframe = NewsDetailsWireframe(newsFeedInfo: newsInfo)
        let view = newsDetailsWireframe.moduleView
        view.loadViewIfNeeded()
        view.showNewsImageFrom(imageURL: newsInfo.jumboImageURL!)
        let promise = expectation(description: "Jumbo image is loaded")
        _ = view.observe(\.newsImageView.image, options: [.initial]) { _, change in
            if change.newValue != nil {
                promise.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
