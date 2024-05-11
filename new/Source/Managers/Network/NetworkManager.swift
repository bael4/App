//
//  NetworkManager.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation
import RealmSwift

class NetworkManager {
    static let shared = NetworkManager()

    var sharedSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let session = URLSession(configuration: configuration)
        return session
    }()

    func fetchDataRealm(
        from url: String,
        completion: @escaping (Result<[ProductModelRealm], Error>) -> Void
    ) {
        
        guard let prepareUrl = URL(string: url) else { return }
        var request = URLRequest(url: prepareUrl)
        request.httpMethod = "GET"

        let task = sharedSession.dataTask(with: request) { (data, response , error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let products = try decoder.decode([ProductModelRealm].self, from: data)
                    completion(.success(products))
                } else {
                    guard let error = error else { return }
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchData(
        from url: String,
        completion: @escaping (Result<[ProductModel], Error>) -> Void
    ) {
        
        guard let prepareUrl = URL(string: url) else { return }
        var request = URLRequest(url: prepareUrl)
        request.httpMethod = "GET"

        let task = sharedSession.dataTask(with: request) { (data, response , error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let products = try decoder.decode([ProductModel].self, from: data)
                    completion(.success(products))
                } else {
                    guard let error = error else { return }
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
