//
//  LoginModel.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/4/23.
//

import Foundation

struct LoginStruct: Decodable{
    var result: Int
    var message: String
    var data: User
    
}

struct User: Decodable {
    let userName: String
    let email: String
    var avatar: String?
    var phone: String?
    var type: Int
    var status: Bool
}
