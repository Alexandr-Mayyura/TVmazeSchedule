//
//  ViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 04.11.2022.
//

import UIKit

enum Link: String {
    case scheduleURL = "https://api.tvmaze.com/schedule"
}

class EpisodeInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       fetchEpisodeInfo()
    }
}

extension EpisodeInfoViewController {
    
    private func fetchEpisodeInfo() {
        guard let url = URL(string: Link.scheduleURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let scheduleEpisodes = try decoder.decode(
                    [EpisodeInfo].self,
                    from: data
                )
                print(scheduleEpisodes)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

