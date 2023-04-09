//
//  UiHelpers.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/1/23.
//

import Foundation
import UIKit

class UiHelpers {
    static func createAlert(title: String, message: String, buttons: [UIAlertAction]? = nil) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        buttons?.forEach({action in
            alert.addAction(action)
        }) ??  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        return alert
    }
    
    static func bindMenus(callback:([String])-> Void ){
        let jsondecoder = JSONDecoder()
        if let data = DeviceData.getMenus()
        {
            if let data2 = try? jsondecoder.decode(ResponseCategory.self, from: data)
            {
                if let d = data2.data {
                    callback(d)
                }
            }
        }
    }
}
