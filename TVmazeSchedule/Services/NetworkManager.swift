//
//  NetworkManager.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case scheduleURL = "https://api.tvmaze.com/schedule"
    case showsURL = "https://api.tvmaze.com/shows"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, completion: @escaping (Result<[T], AFError>) -> Void) {
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [T].self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String?, completion: @escaping (Result<Data, AFError>) -> Void) {
        
        AF.request(url ?? "")
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
