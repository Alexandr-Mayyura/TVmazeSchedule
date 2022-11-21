//
//  ShowCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit
import Kingfisher

class ShowCell: UICollectionViewCell {
    
    @IBOutlet var showName: UILabel!
    @IBOutlet var showImageView: UIImageView! {
        didSet {
            showImageView.layer.cornerRadius = 8
        }
    }
    
    func configure(with show: Show) {
        showName.text = show.name

        guard  let url = URL(string: show.image?.medium ?? "") else { return }

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
}


