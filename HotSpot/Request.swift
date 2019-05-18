//
//  RequestAPI.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/17.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestProtocol {
    associatedtype Response: ResponseProtocol
    var baseUrl: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var parameters: Alamofire.Parameters? { get set }
    var headers: Alamofire.HTTPHeaders? { get }
}

extension RequestProtocol {
    var baseUrl: String {
        return ""
    }
    var encoding: Alamofire.ParameterEncoding {
        return JSONEncoding.default
    }
    var parameters: Alamofire.Parameters? {
        return nil
    }
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
}
