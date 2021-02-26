//
//  CacheManager.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/16.
//

import Foundation

class CacheManager {
    static var cache = [String:Data]()
    static func setStoryCache(_ url:String, _ data:Data?) { cache[url] = data }
    static func getStoryCache(_ url:String) -> Data? { cache[url] }
}
