//
//  TickerCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 27.11.2022.
//

import UIKit
import Kingfisher

class TickerCell: UICollectionViewCell {
    
    @IBOutlet var episodeNameLabel: UILabel!
    @IBOutlet var episodeImage: UIImageView! {
        didSet {
            episodeImage.layer.cornerRadius = 6
        }
    }
    
    
    func configure(with episode: EpisodeInfo) {
        episodeNameLabel.text = episode.show?.name
        
        guard  let url = URL(string: episode.show?.image?.medium ?? "") else { return }
        let processor = DownsamplingImageProcessor(size: episodeImage.bounds.size)
        episodeImage.kf.indicatorType = .activity
        episodeImage.kf.setImage(with: url, options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]
        )
    }
}
