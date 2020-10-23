//
//  NewsCell.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

protocol NewsCellDelegate: class {
    func saveToBookmark(cell: NewsCell)
    func sharePost(cell: NewsCell)
}

class NewsCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var publistedatLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var discriptionLabel: UILabel!
 
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var delegate: NewsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        authorLabel.text = nil
        publistedatLabel.text = nil
        titleLabel.text = nil
        discriptionLabel.text = nil
        contentImageView.image = nil
        bookmarkButton.tintColor = .black
    }
    
    func setImage(model: NewsModel) {
        if let urlStr = model.urlToImage, let url = URL(string: urlStr) {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.contentImageView.image = image
                    }
                } catch {
                    print(error)
                }
            }
        } else {
            self.contentImageView.image = .checkmark
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func saveToBookmark(_ sender: UIButton) {
        delegate?.saveToBookmark(cell: self)
    }
    
    @IBAction func sharePost(_ sender: Any) {
        delegate?.sharePost(cell: self)
    }
}
