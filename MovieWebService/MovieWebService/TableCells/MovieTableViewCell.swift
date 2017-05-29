//
//  MovieTableViewCell.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 12/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK:-  Outlets
    @IBOutlet weak var movieNameLabel:UILabel!
    @IBOutlet weak var movieReleaseDateLabel:UILabel!
    @IBOutlet weak var movieRatingTitleLabel:UILabel!
    @IBOutlet weak var movieRatingValueLabel:UILabel!
    
    //MARK:-  View lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
