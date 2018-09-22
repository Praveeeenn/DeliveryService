//
//  DeliveryListCell.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class DeliveryListCell: BaseCell {
    let cache = NSCache<NSString, NSData>()
    
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134.0/255.0, blue: 249.0/255.0, alpha:1.0) : UIColor.white;
            print(isHighlighted);
            //titleLabel.textColor = isHighlighted ? UIColor.white : UIColor.black;
            //messageLabel.textColor = isHighlighted ? UIColor.white : UIColor.black;
        }
        
    }
    
    var message: Delivery!{
        didSet{
            
        }
    }
    
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.layer.cornerRadius = 2;
        imageView.layer.masksToBounds = true;
        imageView.image = UIImage(named: "about");
        return imageView;
    }();
    
    let dividerLineView : UIView = {
        let view = UIView();
        view.backgroundColor = UIColor.init(white: 0.6, alpha: 0.3);
        view.translatesAutoresizingMaskIntoConstraints  = false;
        return view;
    }();
    
    let titleLabel : UILabel = {
        let label = UILabel();
        label.text = "Place to Place";
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        return label;
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = UIColor.darkGray;
        label.text = "Location";
        label.font = UIFont.systemFont(ofSize: 11);
        return label;
    }()
    
    override func setupViews() {
        
        addSubview(imageView);
        addSubview(dividerLineView);
        setupContainerView();
        
        addConstraintWithFormat("H:|-12-[v0(60)]", views: imageView);
        addConstraintWithFormat("V:[v0(60)]", views: imageView);
        //addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -3).isActive = true
        addConstraintWithFormat("H:|[v0]|", views: dividerLineView);
        addConstraintWithFormat("V:[v0(0.5)]|", views: dividerLineView);
    }
    
    func setupContainerView() {
        let containerView = UIView();
        
        containerView.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(containerView);
        
        addConstraintWithFormat("H:|-90-[v0]|", views: containerView);
        addConstraintWithFormat("V:[v0(50)]", views: containerView);
        addConstraint(NSLayoutConstraint.init(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -3))
        
        containerView.addSubview(titleLabel);
        containerView.addSubview(messageLabel);
        
        addConstraintWithFormat("H:|[v0]|", views: titleLabel);
        addConstraintWithFormat("V:|[v0]", views: titleLabel);
        
        addConstraintWithFormat("H:|[v0]-12-|", views: messageLabel);
        addConstraintWithFormat("V:[v0(24)]|", views: messageLabel);
        
    }
    
}
