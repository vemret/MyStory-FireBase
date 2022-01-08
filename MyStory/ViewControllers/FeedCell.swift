//
//  FeedCell.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 8.01.2022.
//

import UIKit

class FeedCell: UITableViewCell {


    @IBOutlet weak var userNameTxt: UILabel!
    @IBOutlet weak var feedStoryImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
