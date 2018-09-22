//
//  DeliveryDetailViewController.swift
//  Delivery Service
//
//  Created by apple on 21/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {

    let mapView = MKMapView()
    let mapViewModel = MapViewModel()
    
    var delivery: Delivery = Delivery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.mapViewModel.view = self.view
        self.mapViewModel.delivery = delivery
        self.mapViewModel.mapView = self.mapView
    }
    
    func setupUI() {
        self.navigationItem.title = "Delivey Details"
        self.navigationItem.backBarButtonItem?.title = "Back"
    }
    
    
}

