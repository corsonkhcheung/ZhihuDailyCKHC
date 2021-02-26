//
//  Constants.swift
//  ZhihuDailyCKHC
//
//  Created by CHEUNG Kog-hin Corson on 2021/2/1.
//

import Foundation
import UIKit

struct Constants {
    
    static var SCREEN = UIScreen.main.bounds
    static var START_SCREEN_IMAGE_URL = "http://news-at.zhihu.com/api/4/start-image/1080*1776"
    static var LATEST_NEWS = "http://news-at.zhihu.com/api/4/news/latest?r=\(Int.random(in: 1...999999))"
    static var LATEST_NEWS_CONTENT = "http://news-at.zhihu.com/api/4/news/"
    
    static var STORYCELL_ID = "StoryCell"
    static var PAGINGCELL_ID = "PagingCell"
    static var CATEGORY_HEADER_ID = "CategoryHeader"
    
}
