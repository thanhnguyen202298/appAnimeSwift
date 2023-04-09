//
//  File.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/3/23.
//

import Foundation
protocol DataInterface_Delegate{
    func sendText(text: String)
    func sendData(data: Data)
    func sendData(user: LoginStruct)
    
    func popScene()
}
