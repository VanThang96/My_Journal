//
//  Post.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation

struct Post {
    let id : Int
    let title,body : String
}
extension Post : Decodable {
    enum PostCodingKey : String, CodingKey {
        case id
        case title
        case body
    }
    init(decoder : Decoder) throws{
        let container = try decoder.container(keyedBy: PostCodingKey.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }
}
