//
//  Model.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/2.
//

import Foundation

protocol ModelDelegate {
    func storiesFetched(_ stories: [Story])
}

class Model {
    
    var delegate: ModelDelegate?
    
    func getStory() {
        
        let url = URL(string: Constants.LATEST_NEWS)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil || data == nil { return }
            do {
                
                let decoder = JSONDecoder()
                let converter = DateFormatter()
                converter.dateFormat = "yyyymmdd"
                decoder.dateDecodingStrategy = .formatted(converter)
                let response = try decoder.decode(Response.self, from: data!)
                if response.stories != nil {
                    DispatchQueue.main.async {
                        self.delegate?.storiesFetched(response.stories!)
                    }
                }
                dump(response)
            } catch {
                dump(response)
                print(error)
            }
        }
        dataTask.resume()
    }
}
