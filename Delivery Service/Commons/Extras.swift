//
//  Extras.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

extension UIView{
    
    func addConstraintWithFormat(_ format: String, views: UIView...)  {
        var viewsDictionary:[String:UIView] = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)";
            viewsDictionary[key] = view;
            view.translatesAutoresizingMaskIntoConstraints=false;
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
