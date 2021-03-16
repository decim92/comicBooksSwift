//
//  ComicVolume.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftyJSON

class ComicVolume {
    var name:String?
    init(json:JSON) {
        name = json["name"].string
    }
}
