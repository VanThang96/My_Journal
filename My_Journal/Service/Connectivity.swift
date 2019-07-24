//
//  Connectivity.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    static func isConnectedToInternet() ->  Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
