//
//  dataConnect.swift
//  El Comun
//
//  Created by Francisco Ochoa on 22/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import Foundation
import Alamofire


class DataConnect {
    
    var searchResults: [DataModel] = []
    typealias JSONStandard = Dictionary<String, AnyObject>
    let url = URL(string: "https://itunes.apple.com/search?term=U2&limit=50&entity=musicTrack")!
    
    
    
    
    func parse(track dictionary: [String: Any]) -> DataModel{
        let searchResult = DataModel()
        
        searchResult.name = dictionary["trackName"] as! String
        searchResult.artistName = dictionary["artistName"] as! String
        searchResult.artworkSmallURL = dictionary["artworkUrl60"] as! String
        searchResult.artworkLargeURL = dictionary["artworkUrl100"] as! String
        searchResult.storeURL = dictionary["trackViewUrl"] as! String
        searchResult.kind = dictionary["kind"] as! String
        searchResult.currency = dictionary["currency"] as! String
        
        if let price = dictionary["trackPrice"] as? Double {
            searchResult.price = price
        }
        if let genre = dictionary["primaryGenreName"] as? String {
            searchResult.genre = genre
        }
        return searchResult
    }
    
    
    func parse(dictionary: [String: Any]) -> [DataModel] {
        
        guard let array = dictionary["results"] as? [Any] else {
            print("Expected 'results' array")
            return []
        }
        
        var searchResults: [DataModel] = []
        
        for resultDict in array {
            if let resultDict = resultDict as? [String: Any] {
                
                var searchResult: DataModel?
                
                if let wrapperType = resultDict["wrapperType"] as? String {
                    switch wrapperType {
                    case "track":
                        searchResult = parse(track: resultDict)
                    case "audiobook": break
                        
                    case "software": break
                        
                    default:
                        break
                    }
                }
                if let result = searchResult {
                    searchResults.append(result)
                }
            }
        }
        
        return searchResults
    }


    
    
    func downloadData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
            
            if let dict = result.value as? JSONStandard {
                
                
                self.searchResults = self.parse(dictionary: dict)
                
                
            }
            
            
            completed()
        })
    }
    
    

    
    
}
