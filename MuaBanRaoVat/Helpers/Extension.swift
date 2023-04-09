//
//  Extension.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/4/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(url: String){
        
        
        guard !url.isEmpty else {return}
        DispatchQueue(label: "new 1").async {
            
            let uri = URL(string: url)
            if uri != nil
                {
                    if let data = try? Data(contentsOf:uri!)
                    {
                        if let image = UIImage(data: data){
                        DispatchQueue.main.async {[weak self] in
                            
                            self?.image = image
                        }
                    }
                    }
                }
            
        }
    }
}
