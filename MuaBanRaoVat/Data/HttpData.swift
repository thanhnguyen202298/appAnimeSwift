//
//  HttpData.swift
//  MuaBanRaoVat
//
//  Created by Thanh Nguyen on 3/31/23.
//

import Foundation
import UIKit

class HttpData {
    static let PAGE_SIZE = "page_size=20"
    static func byCate(cate: String) -> String { "\(PostURL)/\(cate)"}
    static let Endpoint = "http://localhost:3000/"
    static let publicUpload = Endpoint + "upload/"
    static let categoriesUrl = Endpoint + "category"
    static let loginUrl = Endpoint + "login"
    static let logoutUrl = Endpoint + "logout"
    static let registerUrl = Endpoint + "register"
    static let uploadUrl = Endpoint + "upload"
    static let myPostURL = Endpoint + "myStory"
    static let PostURL = Endpoint + "story"
    
    static func requestData(url: String, data: String? = nil, withToken: Bool = false, method: String, success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        
        let uri = URL(string:url)!
        var request = URLRequest(url: uri)
        request.httpMethod = method
        if(data != nil){
            request.httpBody = data!.data(using: .utf8)
        }
        if(withToken){
            request.addValue("Bearer \(DeviceData.getToken() ?? "")", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { datares, res , err in
            guard let data = datares,
                  err == nil
            else {
                error(err?.localizedDescription ?? "")
                return
                
            }
            success(data)
        }.resume()
    }
    
    static func getCategory(success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: categoriesUrl, method: "GET", success: success, error: error)
    }
    
    static func getMyPost(success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: myPostURL, withToken: true, method: "GET", success: success, error: error)
    }
    
    static func getPost(success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: PostURL, method: "GET", success: success, error: error)
    }
    
    static func loginRequest(data: String, success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: loginUrl, data: data, method: "POST", success: success, error: error)
    }
    
    static func postStory(data: String, success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: PostURL, data: data, withToken: true, method: "POST", success: success, error: error)
    }
    
    static func registerAccount(data: String, success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: registerUrl, data: data, method: "POST", success: success, error: error)
    }
    
    static func getPostByCate(cate: String, success: @escaping (Data) -> Void, error: @escaping (String) -> Void){
        requestData(url: byCate(cate: cate), method: "GET", success: success, error: error)
    }
    
    static func uploadImage(paramName: String,  image: UIImage, callBack: @escaping (String)-> Void){
        let url = URL(string: "http://localhost:3000/upload")
        let boundary = UUID().uuidString
        let session = URLSession.shared
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"khoaIos.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        session.uploadTask(with: urlRequest, from: data, completionHandler: {responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    if json["message"] != nil{
                        if let filename = json["message"] as? String
                        {
                            callBack( HttpData.publicUpload + filename)
                        }
                    }
                }
            }
        }).resume()
    }
}
