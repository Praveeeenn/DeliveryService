//
//  APIService.swift
//  Delivery Service
//
//  Created by apple on 16/09/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permisServicesion"
}

protocol APIServiceProtocol {
    func fetchDeliveries(complete: @escaping ( _ success: Bool, _ deliveries: [Delivery], _ error: APIError? )->())
}

class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    private let session = URLSession.shared
    
    // Simulate a long waiting for fetching
    func fetchDeliveries(complete: @escaping ( _ success: Bool,_ deliveries: [Delivery], _ error: APIError? )->() ) {
        guard let url = URL(string: "\(Constants.API_BASE_URL)deliveries?offset=0&&limit=20") else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil else {
                print("returning error")
                return
            }
            guard let myData = data else {
                print("not returning data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let deliveries = try decoder.decode([Delivery].self, from: myData)
                DispatchQueue.main.async {
                    CoreDataService().storeData(myData)
                    complete(true, deliveries, nil)
                }
            } catch {
                print("JSON Decoding failed")
                DispatchQueue.main.async {
                    complete(false, [Delivery()], nil)
                }
            }
        }
        task.resume()
    }
    
    // MARK:- Public Methods
    func get(url: String, callback: @escaping (_ data: Data?, _ error: Error?)->Void ) {
        guard let link = URL(string: url) else {
            let error = NSError(domain: "URL Error", code: 1, userInfo: nil)
            callback(nil, error)
            return
        }
        let request = URLRequest(url: link)
        let task = session.dataTask(with: request) {(data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
}
