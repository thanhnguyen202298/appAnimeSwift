//
//  ResponseData.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/1/23.
//

import Foundation

struct ResponseCategory: Decodable{
    var result: Int
    var message: String
    var data: [String]?
}
struct ResponseBase: Decodable{
    var result: Int
    var message: String
    var data: String?
}
