//
//  RequestManager.swift
//  challenge
//
//  Created by admin on 17/10/18.
//  Copyright © 2018 Frank. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    internal typealias Dictionary = [String: Any]
    static let shared = RequestManager()
    
    let baseURL: String = "https://s3.amazonaws.com/technical-challenge/v3/contacts.json"
    
    func getJSONRequest(requestParameters: Dictionary = [:],
                        requestHeaders: [String: String] = [:],
                        completion: @escaping ((Result<[Contact],String>) -> Void)) {
        
        Alamofire.request(baseURL, method: .get, parameters: requestParameters,
                          headers: requestHeaders)
            .validate()
            .responseJSON { response in
                let result = response.result

                switch result {
                case .success:
                    guard let data = result.value else {
                        return
                    }

                    let contactList = self.parseData(data: data)
                    completion(.success(contactList))
                case .failure:
                    completion(.failure(Constants.errorMessage))
                }
        }
    }

    func parseData(data: Any) -> [Contact] {
        guard let contactsData = data as? [Dictionary] else {
            return [Contact]()
        }

        let contacts = contactsData.map {
            return Contact(data: $0)
        }

        return contacts
    }
}

enum Result<T, U> {
    case success(T)
    case failure(U)
}
