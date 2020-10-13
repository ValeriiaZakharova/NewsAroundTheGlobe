//
//  NewsCell.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var publistedatLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var discriptionLabel: UILabel!
 
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func saveToBookmark(_ sender: UIButton) {
        
    }
    
    @IBAction func shareContent(_ sender: Any) {
        
    }
    
}
