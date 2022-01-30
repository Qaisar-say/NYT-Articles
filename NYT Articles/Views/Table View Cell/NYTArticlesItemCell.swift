//
//  NYTArticlesItemCell.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import UIKit

class NYTArticlesItemCell : UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var thumbnailImageView: UIImageView! {
        didSet {
            self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.size.height / 2
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    
    // MARK: - Public functions
    
    func setArticlesItemData(article: ArticleItem) {

        self.titleLabel.text = article.title
        self.subtitleLabel.text = article.byline
        self.publishedDateLabel.text = article.publishedDate
        
        guard let media = article.media.first,
            let thumbnailURLString = media.getThumbnailURLString() else {
                return
        }
        NYTNetworkLayer.loadImageFrom(URL: thumbnailURLString, toImageView: self.thumbnailImageView)
        
        
    }
}
