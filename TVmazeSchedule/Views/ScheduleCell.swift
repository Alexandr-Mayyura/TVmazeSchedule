//
//  ScheduleCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit
import Kingfisher

class ScheduleCell: UITableViewCell {
    
    @IBOutlet var showImageView: UIImageView! {
        didSet {
            showImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var nameShowLabel: UILabel!
    @IBOutlet var nameEpisodeLabel: UILabel!
    private var spinnerView = UIActivityIndicatorView()
    
    func configure(with episode: EpisodeInfo) {
        let timeZoneNetwork = episode.show?.network?.country?.timezone ?? ""
        let time = dateFormattedFrom(
            string: episode.airstamp ?? "",
            timeZone: timeZoneNetwork
        )
        
        timeLabel.text = time
        nameEpisodeLabel.text = episode.name
        nameShowLabel.text = episode.show?.name
        showSpinner(in: showImageView)
    
        guard  let url = URL(string: episode.show?.image?.medium ?? "") else { return }
        let processor = DownsamplingImageProcessor(size: showImageView.bounds.size)
        showImageView.kf.indicatorType = .activity
        showImageView.kf.setImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .gray
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true

        view.addSubview(spinnerView)
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
