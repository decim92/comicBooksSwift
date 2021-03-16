//
//  ComicImage.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftyJSON

class ComicImage {
    var originalUrl:String?
    var screenLargeUrl:String?
    init(json:JSON) {
        originalUrl = json["original_url"].string
        screenLargeUrl = json["screen_large_url"].string
    }
}
