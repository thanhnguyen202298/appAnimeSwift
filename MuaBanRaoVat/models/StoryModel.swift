//
//  File.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/30/23.
//

import Foundation

struct StoryRespnse :Decodable {
    var result: Int
    var message: String
    var data: [Story]?
}

struct Story : Decodable {
    var _id: String
    var username: String
    var image: String
    var title: String
    var desc: String
    var dateCreated: String
    var isFull: Bool
    var author: String
    var price: Double
    var cate: String
    
    init(id:String, username: String, image: String, title: String, desc: String, dateCreated: String?, isFull: Bool, author: String, price: Double=0.0, cate: String) {
        self.username = username
        self.image = image
        self.title = title
        self.desc = desc
        let dformat = DateFormatter()
        if(dateCreated == nil)
        {
            dformat.dateFormat = "yyyy/MM/dd"
            self.dateCreated = dformat.string(from: Date.now)
        }
        else {
            self.dateCreated = dateCreated!
        }
        self.isFull = isFull
        self.author = author
        self.cate = cate
        self.price = price
        self._id = id
    }
}
