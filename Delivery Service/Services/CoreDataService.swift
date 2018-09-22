//
//  CoreDataService.swift
//  Delivery Service
//
//  Created by apple on 22/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func fetchPropertise(complete: @escaping ( _ success: Bool, _ realEstatePropertise: Delivery, _ error: APIError?)->())
}

class CoreDataService: CoreDataServiceProtocol {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func fetchPropertise(complete: @escaping (Bool, Delivery, APIError?) -> ()) {
        
    }
    
    func storeData(_ data: Data) {
        self.deleteAllRecords()
        let entity = NSEntityDescription.entity(forEntityName: "DeliveryService", in: context!)
        let recentSearch = NSManagedObject(entity: entity!, insertInto: context!)
        recentSearch.setValue(data, forKey: "json")
        do{
            try context?.save()
            print("Data Saved !")
        }catch{
            print("Failed to save !!")
        }
    }
    
    func fetchData() -> [Delivery] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DeliveryService")
        do{
            let result = try context!.fetch(request)
            for data in result as! [NSManagedObject]{
                guard let data = data.value(forKey: "json") as? Data else { return [Delivery]() }
                let decoder = JSONDecoder()
                let realEstate = try decoder.decode([Delivery].self, from: data)
                return realEstate
            }
        }catch{
            print("Failed While Fetching RealEstate entity in core data")
        }
        return [Delivery]()
    }
    
    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DeliveryService")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context?.execute(deleteRequest)
            try context?.save()
        } catch {
            print ("There was an error while deleting")
        }
    }
    
}
