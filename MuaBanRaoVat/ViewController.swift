//
//  ViewController.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/18/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var comic_icon: UIImageView!
    @IBOutlet weak var comic_bg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        // Do any additional setup after loading the view.
        comic_bg.frame.origin = CGPoint(x: 0, y: -50)
        comic_bg.frame.size = CGSize(width: width * 3 , height: height * 3)
        
        comic_icon.frame.origin.x = 0
        
        UIView.animate(withDuration: 1, animations: { [self] in
            self.comic_icon.frame.origin = CGPoint(
                x: width/2 - comic_icon.frame.width/2,
                y: height/2 - comic_icon.frame.height/2);
            
            self.comic_bg.frame.size = CGSize(
                width: width, height: height)
        })
    }


}

