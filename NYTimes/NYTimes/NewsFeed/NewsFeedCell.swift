//
//  NewsFeedCell.swift
//  AlFuttaim_News
//
//  Created by Alaa Eldin on 11/10/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
