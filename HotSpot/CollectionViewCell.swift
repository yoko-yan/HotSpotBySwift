//
//  CollectionViewCell.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/16.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        // cellの枠の太さ
//        self.layer.borderWidth = 1.0
//        // cellの枠の色
//        self.layer.borderColor = UIColor.black.cgColor
//        // cellを丸くする
//        self.layer.cornerRadius = 8.0
    }
}
