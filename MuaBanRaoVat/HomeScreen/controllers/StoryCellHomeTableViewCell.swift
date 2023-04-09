//
//  StoryCellHomeTableViewCell.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/30/23.
//

import UIKit

class StoryCellHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLbl: UILabel!
    var idStory: String = ""
    
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var nameStory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func select(_ sender: Any?) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setName(name: String){
        nameStory.text = name
    }
    
    func setImage(url: String){
        if let imagec = imageCache.object(forKey: url as NSString){
            self.imageStory.image = imagec as? UIImage
            return
        }
        
        guard !url.isEmpty else {return}
        self.imageStory.setImage(url: url)
    }
    
    func setPrice(price: Double){
        priceLbl.text = price.formatted()
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageStory.image = UIImage(data: data)
            }
        }
    }
}
