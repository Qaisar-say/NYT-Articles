//
//  ViewController.swift
//  NYT Articles
//
//  Created by Qaisar Rizwan on 1/30/22.
//

import UIKit

class NYTArticles: UIViewController {

    // MARK: - Constants
    private static let articlesItemCellIdentifier = "NYTArticlesItemCell"
    private static let resultKey = "results"
    private static let segueIdentifier = "ArticleDetailsSegue"
    
    // MARK: - Outlets
    @IBOutlet private weak var placehollderLabel: UILabel! {
        didSet {
            self.placehollderLabel.isHidden = false
        }
    }
    @IBOutlet private weak var articlesListTableView: UITableView! {
        didSet {
            self.articlesListTableView.isHidden = true
        }
    }
    
    // MARK: - Variables
    private var articlesList: [ArticleItem] = []
    private var refreshControl = UIRefreshControl()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchArticlesList()
        self.setupPullToRefreshData()
    }
    
    private func fetchArticlesList() {
        let articlesURL = NYTNetworkLayer.retriveGetArticleURLString()
        
        NYTNetworkLayer.performGet(with: articlesURL, completion: { response, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let response = response, let results = response[type(of: self).resultKey] as? [[String: Any]] else { return }
            
            self.articlesList.removeAll()
            results.forEach { resultElement in
                self.articlesList.append(ArticleItem(with: resultElement))
            }
            
            DispatchQueue.main.async {
                self.articlesListTableView.reloadData()
                self.articlesListTableView.isHidden = false
                self.placehollderLabel.isHidden = true
                self.refreshControl.endRefreshing()
            }
            
        })
    }
    
    private func setupPullToRefreshData() {
        self.refreshControl.addTarget(self, action: #selector(refreshArticleList), for: .valueChanged)
        self.articlesListTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshArticleList() {
        self.fetchArticlesList()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == type(of: self).segueIdentifier) {
            
            guard let detailsViewController = segue.destination as? NYTArticlesDetailViewController,
                let indexPath = self.articlesListTableView.indexPathForSelectedRow else {
                    return
            }
            
            detailsViewController.articleDetails = self.articlesList[indexPath.row]
        }
    }

}

// MARK: - Table View DataSource
extension NYTArticles: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).articlesItemCellIdentifier,
                                                       for: indexPath as IndexPath) as? NYTArticlesItemCell else {
            return NYTArticlesItemCell()
        }
        
        cell.setArticlesItemData(article: self.articlesList[indexPath.row])
        
        return cell
    }
}

// MARK: - Table View Delegate
extension NYTArticles: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

