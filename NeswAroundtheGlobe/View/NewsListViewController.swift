//
//  NewsListViewController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var news: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
    }
    
    
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        return cell
    }
    
    
}

extension NewsListViewController: UITableViewDelegate {
    
}
