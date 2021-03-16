//
//  Comic.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftyJSON

class Comic: Identifiable {
    var id = UUID()
    var apiDetailUrl:String?
    var dateAdded:String?
    var name:String?
    var issueNumber:String?
    var image:ComicImage?
    var volume:ComicVolume?
    
    init(json:JSON) {
        apiDetailUrl = json["api_detail_url"].string
        dateAdded = json["date_added"].string
        name = json["name"].string
        issueNumber = json["issue_number"].string
        image = ComicImage(json: json["image"])
        volume = ComicVolume(json: json["volume"])
    }
}
