//
//  Response.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/2.
//

import Foundation

struct Response: Codable {
    let date: String?
    let stories: [StoryInformation]?
    let topStories: [StoryInformation]?

    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
    
}

struct StoryInformation: Codable {
    let imageHue, title: String?
    let url: String?
    let hint, gaPrefix: String?
    let images: [String]?
    let type, storyId: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case imageHue = "image_hue"
        case title, url, hint
        case gaPrefix = "ga_prefix"
        case images, type, image
        case storyId = "id"
    }

}
