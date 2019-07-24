//
//  PostViewModel.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation

class PostViewModel {
    var posts : [Post] = []
    
    func getPosts(onCompletion : @escaping () -> ()){
        PostsService.getPosts(onSuccess: { [weak self](posts) in
            self?.posts = posts
            onCompletion()
        }) { (error) in
            print("===== PostViewModel Error: \(error) =====")
        }
    }
    
    func createPost(title : String, body: String, onCompletion : @escaping () -> ()){
        PostsService.createPost(title: title, body: body) { (error) in
            if let err = error {
                print("===== PostViewModel CreatePost Error: \(err) =====")
            }
            onCompletion()
        }
    }
    
    func deletePost(id : Int , onCompletion : @escaping () -> ()){
        PostsService.deletePost(id: id) { (error) in
            if let err = error {
                print("===== PostViewModel DeletePost Error: \(err) =====")
            }
            onCompletion()
        }
    }
    func getCount() -> Int{
        return posts.count
    }
    func getPost(atIndex : Int) -> Post{
        return posts[atIndex]
    }
}
