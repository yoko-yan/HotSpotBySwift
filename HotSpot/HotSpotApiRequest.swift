//
//  SlackApi.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/17.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import Foundation
import Alamofire

struct HotSpotApiRequest: RequestProtocol {
    
    var parameters: Parameters?
    
    var path: String = ""
    
    var method: HTTPMethod = .get
    
    typealias Response = Photo
    
    var baseUrl: String = ""
    
    var encoding: Alamofire.ParameterEncoding = JSONEncoding.default
    
}
