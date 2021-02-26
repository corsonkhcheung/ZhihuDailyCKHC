//
//  Response.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/2.
//

import Foundation

struct Response: Codable {
    let date: String?
    let stories, topStories: [Story]?

    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.stories = try container.decode([Story].self, forKey: .stories)
        self.topStories = try container.decode([Story].self,forKey: .topStories)
        self.date = try container.decode(String.self,forKey: .date)
    }
}

struct Story: Codable {
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
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.storyId = try container.decode(Int.self, forKey: .storyId)
        
        self.imageHue = try container.decode(String.self, forKey: .imageHue)
        self.hint = try container.decode(String.self,forKey: .hint)
        self.gaPrefix = try container.decode(String.self, forKey: .gaPrefix)
        self.images = try container.decode([String].self,forKey: .images)
        self.type = try container.decode(Int.self,forKey: .type)
        self.image = try container.decode(String.self,forKey: .image)
    }
}
