//
//  DeviceHelper.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 4/3/23.
//

import Foundation

class DeviceData {
    private static var KEY_TOKEN_PREFERENCE = "KEY_TOKEN_PREFERENCE"
    private static var KEY_USER_PREFERENCE = "KEY_USER_PREFERENCE"
    private static var KEY_CATE_PREFERENCE = "KEY_USER_PREFERENCE"
    
    
    
    private static var shareData: UserDefaults?
    
    static func getInstant() -> UserDefaults{
        guard shareData != nil else {
            shareData = UserDefaults()
            return shareData!
        }
        return shareData!
    }
    
    static func saveMenus(menu: Data){
        getInstant().set(menu, forKey: KEY_CATE_PREFERENCE)
    }
    
    static func getMenus()-> Data? {
        getInstant().data(forKey: KEY_CATE_PREFERENCE)
    }
    
    static func saveToken(token: String){
        getInstant().set(token, forKey: KEY_TOKEN_PREFERENCE)
    }
    static func getToken()-> String {
        getInstant().string(forKey: KEY_TOKEN_PREFERENCE) ?? ""
    }
    
    static func clearToken(){
        getInstant().set(nil, forKey: KEY_TOKEN_PREFERENCE)
    }
    static func clearUser(){
        getInstant().set(nil, forKey: KEY_USER_PREFERENCE)
    }
    
    static func saveUser(user: Data){
        getInstant().set(user, forKey: KEY_USER_PREFERENCE)
    }
    
    static func getUser()-> Data? {
        getInstant().data(forKey: KEY_USER_PREFERENCE)
    }
}
