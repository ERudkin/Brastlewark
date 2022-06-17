//
//  DetailViewCell.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 16/6/22.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        backGroundView.layer.cornerRadius = 8
    }
    
    
}
