//
//  BaseService.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
    static func callApi(api : TargetType, completion: @escaping (_ response : Data ,_ status : Bool) -> ()){
        Alamofire.request(api.baseURL, method: api.method, parameters: api.task, encoding: JSONEncoding.default, headers: api.headers).responseJSON { (response) in
            guard let data = response.data else{
                completion(Data(), false)
                return
            }
            
            if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                completion(data, true)
                
            } else {
                completion(data, false)
            }
        }
    }
    static func callApiUpload(api : TargetType, completion: @escaping (_ response : Data ,_ status : Bool) -> ()){
        Alamofire.upload(multipartFormData: api.multipartFormData, usingThreshold: UInt64.init(), to: api.baseURL, method: api.method, headers: api.headers) { (result) in
            switch result {
            case .success(let upload,_,_):
                upload.responseJSON(completionHandler: { (response) in
                    guard let data = response.data else{
                        completion(Data(), false)
                        return
                    }
                    
                    if response.response?.statusCode == 204 || response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                        completion(data, true)
                        
                    } else {
                        completion(data, false)
                    }
                })
            case .failure(let err):
                print("===== Call API Upload Error =====" + err.localizedDescription)
                completion(Data(),false)
            }
        }
    }
}
