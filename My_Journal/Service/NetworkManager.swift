//
//  NetworkManager.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation

enum APIEnviroment{
    case staging
    case dev
    case production
}

struct NetworkManager {
    static let enviroment : APIEnviroment = .dev
}
