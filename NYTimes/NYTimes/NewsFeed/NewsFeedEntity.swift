//
//  NewsFeedEntity.swift
//  NYTimes
//
//  Created by Alaa Eldin on 11/12/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import Foundation

struct NewsFeedEntity:Codable {
    let status:String?
    let copyright:String?
    let results:[NewsFeedData]?
}

struct NewsFeedData:Codable {
    let title:String
    let published_date:String
    let id:Int
    let media:[NewsFeedMedia]?
}

struct NewsFeedMedia:Codable {
    let type:String
    let metadata:[NewsFeedMediaInfo]?
    
    private enum CodingKeys : String, CodingKey {
        case  type, metadata = "media-metadata"
    }
}

struct NewsFeedMediaInfo:Codable {
    let url:String?
    let format:String?
    let height:Int?
    let width:Int?
}
