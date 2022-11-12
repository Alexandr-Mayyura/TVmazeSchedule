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
    
    func fetchEpisode(from url: String, completion: @escaping (Result<[EpisodeInfo], AFError>) -> Void) {
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let shows = EpisodeInfo.getEpisodes(from: value)
                    completion(.success(shows))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchShow(from url: String, completion: @escaping (Result<[Show], AFError>) -> Void) {
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let shows = Show.getShows(from: value)
                    completion(.success(shows))
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
