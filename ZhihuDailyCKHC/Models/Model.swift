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
//        let urlForPreviousDates = URL(string: Constants.LATEST_NEWS)
//        guard urlForPreviousDates != nil else { return }
//        let sessionForPreviousDates = URLSession.shared
//        let dataTaskForPreviousDates = sessionForPreviousDates.dataTask(with: urlForPreviousDates!) { (data, response, error) in
//            if error != nil || data == nil { return }
//            do {
//
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(Response.self, from: data!)
//                if response.stories != nil {
//                    DispatchQueue.main.async {
//                        self.feedModelDelegate?.FeedFetched(response.stories!)
////                        self.storyInformationFetched = response.stories!
//                    }
//                }
//                dump(response)
//            } catch {
//                dump(response)
//                print(error)
//            }
//        }
//        dataTaskForPreviousDates.resume()
    }
    
    func getContent(_ selectedContentId: Int) {
        let url = URL(string: "\(Constants.LATEST_NEWS_CONTENT)\(String(selectedContentId))?r=\(Int.random(in: 1...999999))")
        guard url != nil else { return }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.addValue(Constants.NO_STORE_HEADER, forHTTPHeaderField: "Cache-Control")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil { return }
            do {
                
                let decoder = JSONDecoder()
                let response: Optional = try decoder.decode(Content.self, from: data!)
                if response != nil {
                    DispatchQueue.main.async {
                        self.contentModelDelegate?.ContentFetched(response!)
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
    
//    let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request) { (data, respons, error) in
//
//        print(error as Any)
//        if data == nil {return}
//        if response == nil {return}
//
//        let str = "id=10&name=wangwuhua"
//        let data = str.data(using: .utf8)
//        request.httpBody = data
//    }
//    dataTask.resume()

    
}
