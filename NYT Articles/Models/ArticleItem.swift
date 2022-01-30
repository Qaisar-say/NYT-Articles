//
//  ArticleItem.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import Foundation

private struct ItemKeys {
    
    static let fullArticleURL = "url"
    static let adxKeywords = "adx_keywords"
    static let column = "column"
    static let section = "section"
    static let byline = "byline"
    static let type = "type"
    static let title = "title"
    static let abstract = "abstract"
    static let publishedDate = "published_date"
    static let source = "source"
    static let articleId = "id"
    static let assetId = "asset_id"
    static let views = "views"
    static let desFacet = "des_facet"
    static let orgFacet = "org_facet"
    static let perFacet = "per_facet"
    static let geoFacet = "geo_facet"
    static let media = "media"
    
}

class ArticleItem {
    
    // MARK: - Properties
    
    let fullArticleURL: String
    let adxKeywords: String
    let column: String
    let section: String
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let publishedDate: String
    let source: String
    let articleId: String
    let assetId: String
    let views: Int
    let desFacet: [String]
    let orgFacet: [String]
    let perFacet: [String]
    let geoFacet: [String]
    let media: [ArticleMedia]
    
    // MARK: - Initializer
    
    init(with dictionary: [String: Any]) {
        
        self.fullArticleURL = dictionary[ItemKeys.fullArticleURL] as? String ?? ""
        self.adxKeywords = dictionary[ItemKeys.adxKeywords] as? String ?? ""
        self.column = dictionary[ItemKeys.column] as? String ?? ""
        self.section = dictionary[ItemKeys.section] as? String ?? ""
        self.byline = dictionary[ItemKeys.byline] as? String ?? ""
        self.type = dictionary[ItemKeys.type] as? String ?? ""
        self.title = dictionary[ItemKeys.title] as? String ?? ""
        self.abstract = dictionary[ItemKeys.abstract] as? String ?? ""
        self.publishedDate = dictionary[ItemKeys.publishedDate] as? String ?? ""
        self.source = dictionary[ItemKeys.source] as? String ?? ""
        self.articleId = dictionary[ItemKeys.articleId] as? String ?? ""
        self.assetId = dictionary[ItemKeys.assetId] as? String ?? ""
        self.views = dictionary[ItemKeys.views] as? Int ?? 0
        self.desFacet = dictionary[ItemKeys.desFacet] as? [String] ?? []
        self.orgFacet = dictionary[ItemKeys.orgFacet] as? [String] ?? []
        self.perFacet = dictionary[ItemKeys.perFacet] as? [String] ?? []
        self.geoFacet = dictionary[ItemKeys.geoFacet] as? [String] ?? []
        
        guard let media = dictionary[ItemKeys.media] as? [[String: Any]] else {
            self.media = []
            return
        }
        
        var mediaItems: [ArticleMedia] = []
        media.forEach { mediaElement in
            mediaItems.append(ArticleMedia(with: mediaElement))
        }
        self.media = mediaItems
    }
    
}
