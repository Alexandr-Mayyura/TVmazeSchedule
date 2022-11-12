//
//  ScheduleCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    @IBOutlet var showImageView: UIImageView! {
        didSet {
            showImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var nameShowLabel: UILabel!
    @IBOutlet var nameEpisodeLabel: UILabel!
    
    func configure(with episode: EpisodeInfo) {
        let timeZoneNetwork = episode.show.network.country.timezone
        let time = dateFormattedFrom(
            string: episode.airstamp,
            timeZone: timeZoneNetwork
        )
        
        timeLabel.text = time
        nameEpisodeLabel.text = episode.name
        nameShowLabel.text = episode.show.name
        
        let url = episode.show.image.medium
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.showImageView.image = UIImage(data: imageData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ScheduleCell {
    func dateFormattedFrom(string: String, timeZone: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let data = dateFormatter.date(from: string) else { return "" }
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "HH:mm"
        let dateForm = dateFormatter.string(from: data)
        return dateForm
    }
}
