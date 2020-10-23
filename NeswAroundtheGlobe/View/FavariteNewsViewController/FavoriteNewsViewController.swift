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
    
    var favoriteNews: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        favoriteNews = NewsDataController.shared.favoriteNews
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteNews = NewsDataController.shared.favoriteNews
        tableView.reloadData()
    }
}

extension FavoriteNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        //cell.delegate = self
        let post = favoriteNews[indexPath.row]
        cell.authorLabel.text = post.author
        cell.discriptionLabel.text = post.description
        cell.publistedatLabel.text = post.publishedAt
        cell.titleLabel.text = post.title
        cell.setImage(model: post)
        
        return cell
    }
}

extension FavoriteNewsViewController: UITableViewDelegate {
    
}
