//
//  NYTArticlesDetailViewController.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import UIKit

class NYTArticlesDetailViewController: UIViewController {

    // MARK: - Constants
    private static let titleText = "Article Details"
    
    // MARK: - Outlets
    
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sectionLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    @IBOutlet private weak var byLineLabel: UILabel!
    @IBOutlet private weak var abstractLabel: UILabel!
    
    // MARK: - Variables
    
    var articleDetails: ArticleItem?
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = type(of: self).titleText
        self.setupArticleDetails()
    }
    
    private func setupArticleDetails() {
        guard let articleDetails = articleDetails else { return }
        
        self.titleLabel.text = articleDetails.title
        self.sectionLabel.text = articleDetails.section
        self.publishedDateLabel.text = articleDetails.publishedDate
        self.byLineLabel.text = articleDetails.byline
        self.abstractLabel.text = articleDetails.abstract
        
        guard let media = articleDetails.media.first,
            let imageURLString = media.getImageURLString() else {
                return
        }
        NYTNetworkLayer.loadImageFrom(URL: imageURLString, toImageView: self.articleImageView)
        
    }

    // MARK: - Action Items
    
    @IBAction func readFullArticleTapAction(_ sender: UIButton) {
        guard let articleDetails = articleDetails,
            let articleURL = URL(string: articleDetails.fullArticleURL) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(articleURL) {
            UIApplication.shared.open(articleURL, options: [:], completionHandler: nil)
        }
    }
}
