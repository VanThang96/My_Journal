//
//  APIService.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import Alamofire

enum API {
    case getPosts()
    case createPost(title : String,body : String)
    case deletePost(id : Int)
}
extension API : TargetType {
    
    var enviromentBaseUrl : String{
        switch NetworkManager.enviroment {
        case .dev:
            return "http://localhost:1337/"
        case .production:
            return "http://localhost:1337/"
        case .staging:
            return "http://localhost:1337/"
        }
    }
    
    var baseURL: URL{
        guard let url = URL(string: url) else {
            fatalError("Could not configure API Please change the URL")
        }
        return url
    }
    
    var url : String{
        return enviromentBaseUrl + path
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "posts"
        case .createPost:
            return "post"
        case .deletePost(let id):
            return "post/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        case .createPost:
            return .post
        case .deletePost:
            return .delete
        }
    }
    
    var task: Parameters?{
        switch self {
        case .getPosts,.deletePost:
            return nil
        case .createPost(let title,let body):
            let params : [String : Any] = ["title" : title , "body" : body]
            return params
        }
    }
    
    var headers: [String : String]?{
        switch self {
        case .getPosts,.deletePost:
            return nil
        case .createPost:
            return ["Content-Type": "application/json"]
        }
    }
    
    var multipartFormData: (MultipartFormData) -> (){
        switch self {
        default:
            return {_ in}
        }
    }
    
    
}

protocol TargetType {
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Parameters? { get }
    
    /// The type of validation to perform on the request. Default is `.none`.
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    ///The data to be used in the upload request
    var multipartFormData : (_ multipartFormData: MultipartFormData)->() { get }
}
