//
//  DeliveryListCollectionViewController.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class DeliveryListCollectionViewController: UICollectionViewController {
    
    var deliveryListCollectionDataSource: DeliveryListCollectionDataSource = DeliveryListCollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
    }

    func setupDataSource() {
        APIService().fetchDeliveries { (bool, delivaries, error) in
            if error != nil {
                print(error.debugDescription)
            }
            self.deliveryListCollectionDataSource.deliveries = CoreDataService().fetchData()
            self.deliveryListCollectionDataSource.collectionView?.reloadData()
        }
        self.deliveryListCollectionDataSource.deliveryListCollectionViewController = self
        self.deliveryListCollectionDataSource.collectionView = self.collectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Things to Deliver"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.title = ""

    }
    
    
    
}
