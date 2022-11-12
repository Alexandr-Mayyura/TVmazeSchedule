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

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetch(from url: String, completion: @escaping (Result<[Show], AFError>) -> Void) {
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let shows = Show.getShows(from: value)
                    print(shows)
                    completion(.success(shows))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        DispatchQueue.global().async {
            guard let dataImage = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(dataImage))
            }
        }
    }
}
