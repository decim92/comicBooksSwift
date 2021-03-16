//
//  ComicAPI.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Combine
import Alamofire
import SwiftyJSON

class IssueDetailAPI {
    
    @Published var issueDetail: IssueDetail?
    @Published var isLoading = false
    
    func getIssueDetail(with url: String) {
        isLoading = true
        
        let url = "\(url)?api_key=\(Constants.apiKey)&format=json"
        AF.request(url, method: .get, headers: nil).responseJSON { [weak self] response in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success:
                if let value = response.value {
                    let json = JSON(value)
                    weakSelf.isLoading = false
                    weakSelf.issueDetail = IssueDetail(json: json["results"])
                } else {
                    weakSelf.isLoading = false
                }

            case .failure( _):
                weakSelf.isLoading = false
            }
        }
    }
}
