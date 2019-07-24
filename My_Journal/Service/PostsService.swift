//
//  PostsService.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import Alamofire

class PostsService: BaseService {
    static func getPosts(onSuccess : @escaping (_ posts : [Post]) -> () , onError : @escaping (_ error : String) -> ()){
        guard Connectivity.isConnectedToInternet() else{
            onError("Please connect internet again!")
            return
        }
        BaseService.callApi(api: API.getPosts()) { (data, status) in
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                print("===== List Posts =====\n" + "\(posts)")
                onSuccess(posts)
            } catch {
                onError("Get history check in fail!!")
            }
        }
    }
    static func createPost(title : String, body : String, onCompletion : @escaping (_ error : String?) -> ()){
        guard Connectivity.isConnectedToInternet() else {
            onCompletion("Please connect internet again!")
            return
        }
        BaseService.callApi(api: API.createPost(title: title, body: body)) { (data, status) in
            guard status else {
                print("===== Server Error =====")
                onCompletion("Server error, please try again later!")
                return
            }
            onCompletion(nil)
        }
    }
    static func deletePost(id : Int, onCompletion : @escaping (_ error : String?) -> ()){
        guard Connectivity.isConnectedToInternet() else {
            onCompletion("Please connect internet again!")
            return
        }
        BaseService.callApi(api: API.deletePost(id: id)) { (data, status) in
            guard status else {
                print("===== Server Error =====\n" + "\(data.base64EncodedString())")
                onCompletion("Server error, please try again later!")
                return
            }
            onCompletion(nil)
        }
    }
}
