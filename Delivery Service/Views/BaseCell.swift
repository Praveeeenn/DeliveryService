//
//  BaseCell.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Init(coder:) has not been implemented")
    }
    
}
