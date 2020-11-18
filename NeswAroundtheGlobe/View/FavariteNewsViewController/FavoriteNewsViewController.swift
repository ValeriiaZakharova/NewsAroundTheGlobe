//
//  FavoriteNewsViewController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class FavoriteNewsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var favoriteNews: [NewsViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        favoriteNews = NewsDataController.shared.viewModels
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteNews = NewsDataController.shared.viewModels
        tableView.reloadData()
    }

    func update(news: NewsViewModel) {
        guard let index = findNewsIndex(identifier: news.identifier) else { return }
        favoriteNews[index] = news
    }
    
    func findNewsIndex(identifier: UUID) -> Int? {
        let newsIndex = favoriteNews.firstIndex(where: { internalNews -> Bool in
            return internalNews.identifier == identifier
        })
        return newsIndex
    }
    
}

extension FavoriteNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.delegate = self
        let post = favoriteNews[indexPath.row]
        cell.authorLabel.text = post.author
        cell.discriptionLabel.text = post.description
        cell.publistedatLabel.text = post.publishedAt
        cell.titleLabel.text = post.title
        cell.setImage(model: post)
        cell.bookmarkButton.isSelected = post.isFavorite
        
        return cell
    }
}

extension FavoriteNewsViewController: UITableViewDelegate {
    
}

extension FavoriteNewsViewController: NewsCellDelegate {
    

    func saveToBookmark(cell: NewsCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var post = favoriteNews[indexPath.row]
        
        post.isFavorite = false
        NewsDataController.shared.remove(news: post)
        self.update(news: post)
        tableView.reloadData()
        cell.bookmarkButton.isSelected = false
        tableView.reloadData()
    }
    
    func sharePost(cell: NewsCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let post = favoriteNews[indexPath.row]
        let items = [post.url]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
