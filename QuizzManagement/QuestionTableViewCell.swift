//
//  QuestionTableViewCell.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var answer1TextField: UILabel!
    @IBOutlet weak var answer2TextField: UILabel!
    @IBOutlet weak var answer3TextField: UILabel!
    @IBOutlet weak var answer4TextField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(question: Question){
        textField.text = question.text
        answer1TextField.text = question.answer1
        answer2TextField.text = question.answer2
        answer3TextField.text = question.answer3
        answer4TextField.text = question.answer4
    }

}
