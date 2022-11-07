//
//  NetworkManager.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import Foundation

enum Link: String {
    case scheduleURL = "https://api.tvmaze.com/schedule"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
