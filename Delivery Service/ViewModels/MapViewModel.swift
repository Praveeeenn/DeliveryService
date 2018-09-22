//
//  MapViewModel.swift
//  Delivery Service
//
//  Created by apple on 22/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation
import MapKit

public class MapViewModel : NSObject {
    
    var locationManager = CLLocationManager()
    var view: UIView?
    
    var delivery: Delivery = Delivery()
    
    public var mapView: MKMapView? {
        didSet {
            self.setupUI()
            setupMapView()
        }
    }
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            print("User denied location permissions.")
        }
    }
    
    @objc func moveToCurrentLocation() {
        self.getLocation()
        guard let userLocationCoordinate = mapView?.userLocation.coordinate else { return }
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = userLocationCoordinate
        mapRegion.span.latitudeDelta = CLLocationDegrees(0.2)
        mapRegion.span.longitudeDelta = CLLocationDegrees(0.2)
        mapView?.setRegion(mapRegion, animated: true)
        let placemark = MKPlacemark(coordinate: userLocationCoordinate)
        let annotation = MKPointAnnotation()
        annotation.title = "My Location"
        annotation.subtitle = "Subtitle of location"
        mapView?.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView?.setRegion(region, animated: true)
    }
    
    func setupMapView() {
        getLocation()
        mapView?.showsUserLocation = true
        let location = CLLocation(latitude: delivery.location?.lat ?? 0.0, longitude: delivery.location?.lng ?? 0.0)
        let regionRadius: CLLocationDistance = 300.0
        var region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        region.center = location.coordinate
        region.span.latitudeDelta = CLLocationDegrees(0.1)
        region.span.longitudeDelta = CLLocationDegrees(0.1)
        mapView?.showsScale = true
        mapView?.setRegion(region, animated: true)
        let camera = MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 100.0, pitch: 0.5, heading: .greatestFiniteMagnitude)
        mapView?.setCamera(camera, animated: true)
        mapView?.mapType = .standard
        mapView?.showsUserLocation = true
        guard let frame = view?.frame else { return }
        mapView?.frame = frame
        mapView?.mapType = MKMapType.standard
        mapView?.isZoomEnabled = true
        mapView?.isScrollEnabled = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = delivery.location?.address
        annotation.subtitle = delivery.description
        mapView?.addAnnotation(annotation)
    }
    
    func setupUI() {
        // Or, if needed, we can position map in the center of the view
        guard let center = view?.center else { return }
        mapView?.center = center
        view?.addSubview(mapView!)
        
        //BottomContainerView
        let bottomContainerView = UIView()
        mapView?.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.4078431373, blue: 0.1882352941, alpha: 1)
        bottomContainerView.layer.cornerRadius = 50
        bottomContainerView.layer.borderColor = UIColor.white.cgColor
        bottomContainerView.layer.borderWidth = 5.0
        bottomContainerView.clipsToBounds = true
        bottomContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        bottomContainerView.bottomAnchor.constraint(equalTo: (self.view?.bottomAnchor)!, constant: -40).isActive = true
        bottomContainerView.leftAnchor.constraint(equalTo: (self.view?.leftAnchor)!, constant: 10).isActive = true
        bottomContainerView.rightAnchor.constraint(equalTo: (self.view?.rightAnchor)!, constant: -10).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //ImageView
        let imageView: UIImageView = {
            let imageView: UIImageView = UIImageView()
            imageView.image = UIImage(named: "lala")
            imageView.fetchImage(delivery.imageUrl ?? "")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 5
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 5.0
            imageView.clipsToBounds = true
            return imageView
        }()
        bottomContainerView.addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: bottomContainerView.leftAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: 0).isActive = true
        
        //titleLabel
        let titleLabel: UILabel = {
            let label = UILabel ()
            label.text = "Somewhere to Somewhere"
            label.text = delivery.description
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 2
            return label
        }()
        bottomContainerView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 4).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.6).isActive = true
        
        //locationLabel
        let locationLabel: UILabel = {
            let label = UILabel()
            label.text = "Location"
            label.text = delivery.location?.address
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.white
            return label
        }()
        bottomContainerView.addSubview(locationLabel)
        locationLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor, constant: 10).isActive = true
        locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //locationButton
        let locationButton: UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 25
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 5
            button.setImage(#imageLiteral(resourceName: "nav"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.moveToCurrentLocation), for: .touchUpInside)
            return button
        }()
        self.mapView?.addSubview(locationButton)
        locationButton.rightAnchor.constraint(equalTo: (self.mapView?.rightAnchor)!, constant: -5).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: -70).isActive = true
    }

    
}

