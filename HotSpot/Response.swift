//
//  EmojiModel.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/17.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import Foundation

protocol ResponseProtocol: Decodable {
}

struct Photo: ResponseProtocol {
    var url: String
}
