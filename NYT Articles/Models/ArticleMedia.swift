//
//  ArticleMedia.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import Foundation

private struct MediaKeys {
    
    static let type = "type"
    static let subtype = "subtype"
    static let caption = "caption"
    static let copyright = "copyright"
    static let approvedForSyndication = "approved_for_syndication"
    static let mediaMetadata = "media-metadata"
    
}

class ArticleMedia {

    // MARK: - Constatnts
    
    private static let square320 = "Standard Thumbnail"
    private static let large = "mediumThreeByTwo440"
    
    // MARK: - Properties

    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [ArticleMediaMetadata]
    
    // MARK: - Initializer
    
    init(with dictionary: [String: Any]) {
        self.type = dictionary[MediaKeys.type] as? String ?? ""
        self.subtype = dictionary[MediaKeys.subtype] as? String ?? ""
        self.caption = dictionary[MediaKeys.caption] as? String ?? ""
        self.copyright = dictionary[MediaKeys.copyright] as? String ?? ""
        self.approvedForSyndication = dictionary[MediaKeys.approvedForSyndication] as? Int ?? 0
        
        var mediaMetadataItems: [ArticleMediaMetadata] = []

        
        guard let mediaMetadata = dictionary[MediaKeys.mediaMetadata] as? [[String: Any]] else {
            self.mediaMetadata = []
            return
        }
        
        mediaMetadata.forEach { metadataElement in
            mediaMetadataItems.append(ArticleMediaMetadata(with: metadataElement))
        }
        self.mediaMetadata = mediaMetadataItems
    }
    
    // MARK: - Functions
    
    func getThumbnailURLString() -> String? {
        
        let squareMediaList = self.mediaMetadata.filter {  $0.format == ArticleMedia.square320 }
        
        guard let squareMedia = squareMediaList.first else {
            return nil
        }
        
        return squareMedia.mediaURLString
    }
    
    func getImageURLString() -> String? {
        
        let imageMediaList = self.mediaMetadata.filter {  $0.format == ArticleMedia.large }
        
        guard let imageMedia = imageMediaList.first else {
            return nil
        }
        
        return imageMedia.mediaURLString
    }
}
