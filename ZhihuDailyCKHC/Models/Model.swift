//
//  Model.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/2.
//

import Foundation

protocol FeedModelDelegate { func FeedFetched(_ stories: [StoryInformation]) }
protocol ContentModelDelegate { func ContentFetched(_ content: Content) }

class Model {
    var feedModelDelegate: FeedModelDelegate?
    var contentModelDelegate: ContentModelDelegate?
    
    func getLatestFeed() {
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
                        self.feedModelDelegate?.FeedFetched(response.stories!)
//                        self.storyInformationFetched = response.stories!
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
    
    func getContent(_ selectedContentId: Int) {
        let url = URL(string: "\(Constants.LATEST_NEWS) + \(String(selectedContentId))")
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil || data == nil { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Content.self, from: data!)
                if response.body != nil {
                    DispatchQueue.main.async {
                        self.contentModelDelegate?.ContentFetched(response)
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
    
//    func getImage(url: String, completion: @escaping (Data?) -> Void) {
//        guard let url = URL(string: Content.image?[0] ?? "") else { completion(nil) }
//
//        if let cachedImage = CacheManager.imageCache.object(forKey: NSString(string: Content.image?[0] ?? "")) {
//            completion(cachedImage as Data)
//        } else {
//            URLSession.shared.dataTask(with: Content.image?[0] ?? "") { (data, response, error) in
//                guard error == nil, let data = data else { completion(nil) }
//                CacheManager.imageCache.setObject(data as NSData, forKey: NSString(string: Content.image?[0] ?? ""))
//                completion(data)
//            }.resume()
//
//        }
//    }
    
}
