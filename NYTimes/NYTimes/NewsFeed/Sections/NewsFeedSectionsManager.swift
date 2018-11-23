//
//  NewsFeedSectionsManager.swift
//  NYTimes
//
//  Created by Alaa Eldin on 11/12/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import Foundation

class NewsFeedSectionsManager {
    var newsFeedSections: [NewsFeedSection]?

    init() {
        if let pathURL = Bundle.main.url(forResource: "Sections", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: pathURL)
                let decoder = PropertyListDecoder()
                newsFeedSections = try decoder.decode([NewsFeedSection].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}

struct NewsFeedSection: Codable {
    let name: String
    let key: String
}
