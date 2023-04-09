//
//  OweTableViewCell.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/3/23.
//

import UIKit

class OweTableViewCell: UITableViewCell {

    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var storyTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setName(name: String){
        storyTitle.text = name
    }
    
    func setImage(url: String){
        self.storyImage.setImage(url: url)
          
    }
}
