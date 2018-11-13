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
    let abstract:String
    let media:[NewsFeedMedia]?
    
    // this is to fetch directly the thumnail we would like to use in our application
    // we chose to only show image type and we select the square 320 dimension if exists
    var thumbnailURL:String? {
        get{
            let thumnailMedia = fetchMediaInfo(format: "square320")
            guard thumnailMedia != nil else{
                return nil
            }
            return thumnailMedia!.url
        }
    }
    var jumboImageURL:String? {
        get{
            let thumnailMedia = fetchMediaInfo(format: "Jumbo")
            guard thumnailMedia != nil else{
                return nil
            }
            return thumnailMedia!.url
        }
    }
    func fetchMediaInfo (format:String)-> NewsFeedMediaInfo? {
        guard media != nil, media!.count > 0 else {
            return nil
        }
        let firstMediaInfo = media![0]
        let metadata = firstMediaInfo.metadata
        guard firstMediaInfo.type == "image", metadata != nil , metadata!.count > 0 else {
            return nil
        }
        return metadata!.filter {$0.format == format}[0]
    }
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
