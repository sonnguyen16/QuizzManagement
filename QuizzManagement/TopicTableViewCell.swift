//
//  TopicTableViewCell.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(topic: Topic){
        topicLabel.text = topic.title
    }
}
