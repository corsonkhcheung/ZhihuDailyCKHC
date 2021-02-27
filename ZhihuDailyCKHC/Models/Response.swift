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
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.stories = try container.decode([StoryInformation].self, forKey: .stories) // 跑完这一行直接回到了init那一行，并且在Model那里进入了catch，估计就是在这里throw了某种error
        self.topStories = try container.decode([StoryInformation].self,forKey: .topStories)
        self.date = try container.decode(String.self,forKey: .date)
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
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.storyId = try container.decode(Int.self, forKey: .storyId)
        
        self.imageHue = try container.decode(String.self, forKey: .imageHue)
        self.hint = try container.decode(String.self,forKey: .hint)
        self.gaPrefix = try container.decode(String.self, forKey: .gaPrefix)
        self.images = try container.decode([String].self,forKey: .images) //在这里报错nw_protocol_get_quic_image_block_invoke dlopen libquic failed
        self.type = try container.decode(Int.self,forKey: .type)
        self.image = try container.decode(String.self,forKey: .image) //所谓CodingKey没有对应value估计讲的就是这一行，然而JSON里面是有值的
    }
}
