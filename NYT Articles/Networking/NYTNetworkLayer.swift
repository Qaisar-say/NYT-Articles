//
//  NYTNetworkLayer.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import Foundation
import UIKit

class NYTNetworkLayer {
    
    private static let baseArticleURL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
    private static let articleURLQuery = ".json?api-key="
    private static let section = "all-sections"
    private static let period = "7"
    private static let apiKey = "o7sksrGPWxvuRIi8ISHbEmBKi7srjI6u"
    
    class func performGet(with urlString: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        guard let getURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: getURL, completionHandler: { responseData, _, error in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let data = responseData else { return }
            do {
                guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(nil, error)
                    return
                }
                completion(response, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
        }).resume()
    }
    
    class func loadImageFrom(URL urlString: String, toImageView: UIImageView, placeholderImege: UIImage? = nil) {
        toImageView.image = placeholderImege
        guard let imageURL = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: imageURL, completionHandler: { data, _, _ in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                toImageView.image = UIImage(data: data)
            }
            
        }).resume()
    }
    
    class func retriveGetArticleURLString() -> String {
        return "\(self.baseArticleURL)\(self.section)/\(self.period)\(self.articleURLQuery)\(self.apiKey)"
    }
    
}
