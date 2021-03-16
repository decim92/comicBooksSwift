//
//  Credit.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftyJSON

class Credit {
    var apiDetailUrl:String?
    var name:String?
    
    init(json:JSON) {
        apiDetailUrl = json["api_detail_url"].string
        name = json["name"].string
    }
}
