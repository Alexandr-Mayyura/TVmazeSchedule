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
    
    @IBOutlet var episodeCollectionView: UICollectionView!
    
    private var episodeInfo: [EpisodeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEpisodeInfo()
        episodeCollectionView.dataSource = self
    }
}

extension EpisodeInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return episodeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodCell", for: indexPath)
        guard let cell = cell as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
  
        let aaa = self.episodeInfo[indexPath.item].show
        cell.nameShowLabel.text = aaa?.name
        cell.nameEpisodLabel.text = episodeInfo[indexPath.item].name
        return cell
    }
}

extension EpisodeInfoViewController {
    
    private func fetchEpisodeInfo() {
        guard let url = URL(string: Link.scheduleURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
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
                    self?.episodeInfo = scheduleEpisodes
                
                DispatchQueue.main.async {
                    self?.episodeCollectionView.reloadData()
                   
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

