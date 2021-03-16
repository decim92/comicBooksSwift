//
//  ComicAPI.swift
//  Comic Books
//
//  Created by Douglas Poveda on 15/03/21.
//

import Combine
import Alamofire
import SwiftyJSON

class ComicAPI {
    
    @Published var comicList: [Comic]?
    @Published var isLoading = false
            
    func getComicList() {
        isLoading = true
        
        let url = "\(Constants.baseUrl)/issues/?api_key=\(Constants.apiKey)&format=json"
        AF.request(url, method: .get, headers: nil).responseJSON { [weak self] response in
            guard let weakSelf = self else { return }
            switch response.result{
            case .success:
                if let value = response.value {
                    let json = JSON(value)
                    if let results = json["results"].array {
                        weakSelf.isLoading = false
                        weakSelf.comicList = weakSelf.comicList(from: results)
                    }
                } else {
                    weakSelf.isLoading = false
                }

            case .failure( _):
                weakSelf.isLoading = false
            }
        }
    }
    
    private func comicList(from array:[JSON]?) -> [Comic] {
        var comics = [Comic]()
        if let results = array {
            for result in results {
                let comic = Comic(json: result)
                comics.append(comic)
            }
        }
        return comics
    }
}
