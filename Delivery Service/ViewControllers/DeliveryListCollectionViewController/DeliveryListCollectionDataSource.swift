//
//  DeliveryListCollectionDataSource.swift
//  Delivery Service
//
//  Created by apple on 17/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit

class DeliveryListCollectionDataSource: NSObject {

    let  deliveryListCell = "DeliveryListCell"

    var deliveryListCollectionViewController: DeliveryListCollectionViewController?
    
    var deliveries: [Delivery] = [Delivery]()
    
    var collectionView: UICollectionView? {
        didSet {
            self.collectionView?.register(DeliveryListCell.self, forCellWithReuseIdentifier: deliveryListCell)
            self.collectionView?.backgroundColor = UIColor.white
            self.collectionView?.alwaysBounceVertical = true
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self
            self.collectionView?.reloadData()
        }
    }
}

extension DeliveryListCollectionDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return deliveries.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: deliveryListCell, for: indexPath) as? DeliveryListCell{
            let delivery = deliveries[indexPath.row]
            cell.titleLabel.text = "🚚 " + (delivery.description ?? "")
            cell.messageLabel.text = " 🗺 "+((delivery.location?.address) ?? "")
            cell.imageView.fetchImage(delivery.imageUrl ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.deliveryListCollectionViewController?.view.frame.width ?? 0, height: 70)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected")
        let deliveryDetailViewController: DeliveryDetailViewController = DeliveryDetailViewController()
        deliveryDetailViewController.delivery = deliveries[indexPath.row]
        self.deliveryListCollectionViewController?.navigationController?.pushViewController(deliveryDetailViewController, animated: true)
    }

}
