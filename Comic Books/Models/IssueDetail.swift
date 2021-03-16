//
//  IssueDetail.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Foundation
import SwiftyJSON

class IssueDetail {
    var characterCredits:[Credit]?
    var teamCredits:[Credit]?
    var locationCredits:[Credit]?
    var image:ComicImage?
    
    init(json:JSON) {
        characterCredits = getCreditsFrom(json: json["character_credits"].array)
        teamCredits = getCreditsFrom(json: json["team_credits"].array)
        locationCredits = getCreditsFrom(json: json["location_credits"].array)
        image = ComicImage(json: json["image"])
        
    }
    
    private func getCreditsFrom(json array: [JSON]?) -> [Credit] {
        var credits = [Credit]()
        if let characterCredits = array {
            for credit in characterCredits {
                credits.append(Credit(json: credit))
            }
        }
        return credits
    }
}
