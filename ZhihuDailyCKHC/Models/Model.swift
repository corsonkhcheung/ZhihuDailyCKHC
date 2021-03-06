//
//  Model.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/2.
//

import Foundation

protocol FeedModelDelegate {
    func asignToStoriesFromFeedFetched(_ stories: [StoryInformation])
    func asignToTopStoriesFromFeedFetched(_ stories: [StoryInformation])
    func asignToStoriesFromPreviousFeedFetched(_ newStories: [StoryInformation])
}
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
                        self.feedModelDelegate?.asignToStoriesFromFeedFetched(response.stories!)
                        self.feedModelDelegate?.asignToTopStoriesFromFeedFetched(response.topStories!)
                    }
                }
                dump(response)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
<<<<<<< HEAD
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: currentDate)
        let dateSubstrings: [Substring] = dateString.split(separator: "/")
        let dateComponent: [String] = dateSubstrings.compactMap { "\($0)" }
        
        var month: String
        if Int(dateComponent[0])! >= 10 {
            month = dateComponent[0]
        } else {
            month = "0\(dateComponent[0])"
        }
        var date: String
        if Int(dateComponent[1])! >= 10 {
            date = dateComponent[1]
        } else {
            date = "0\(dateComponent[1])"
        }
        
        let urlForPreviousDates = URL(string: "\(Constants.PREVIOUS_NEWS)20\(dateComponent[2])\(month)\(date)?r=\(Int.random(in: 1...999999))")
        guard urlForPreviousDates != nil else { return }
        
        var requestForPreviousDates = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        requestForPreviousDates.addValue(Constants.NO_STORE_HEADER, forHTTPHeaderField: "Cache-Control")
        requestForPreviousDates.httpMethod = "GET"
        
        let sessionForPreviousDates = URLSession.shared
        let dataTaskForPreviousDates = sessionForPreviousDates.dataTask(with: requestForPreviousDates) { (data, response, error) in
            if error != nil || data == nil { return }
            do {

                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data!)
                if response.stories != nil {
                    DispatchQueue.main.async {
                        self.feedModelDelegate?.asignToStoriesFromPreviousFeedFetched(response.stories!)
                    }
                }
                dump(response)
            } catch {
                print(error)
            }
        }
        dataTaskForPreviousDates.resume()
=======
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
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
    }
    
    func getContent(_ selectedContentId: Int) {
        let url = URL(string: "\(Constants.LATEST_NEWS_CONTENT)\(String(selectedContentId))?r=\(Int.random(in: 1...999999))")
        guard url != nil else { return }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.addValue(Constants.NO_STORE_HEADER, forHTTPHeaderField: "Cache-Control")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
<<<<<<< HEAD
        let dataTask = session.dataTask(with: request) { (JSONdata, response, error) in
            if error != nil || JSONdata == nil { return }
            do {
                
                let newJSONdecoder = JSONDecoder()
                let result: Optional = try newJSONdecoder.decode(Content.self, from: JSONdata!)
                if result != nil {
                    DispatchQueue.main.async {
                        self.contentModelDelegate?.ContentFetched(result!)
=======
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil { return }
            do {
                
                let decoder = JSONDecoder()
                let response: Optional = try decoder.decode(Content.self, from: data!)
                if response != nil {
                    DispatchQueue.main.async {
                        self.contentModelDelegate?.ContentFetched(response!)
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
                    }
                }
                dump(result)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
    
<<<<<<< HEAD
=======
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

    
>>>>>>> 4bc9684ec38e57f13f7bfd9dd16280da59d843c2
}
