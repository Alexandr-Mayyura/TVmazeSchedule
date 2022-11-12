//
//  ShowCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class ShowCell: UICollectionViewCell {
    
    @IBOutlet var showName: UILabel!
    @IBOutlet var showImageView: UIImageView! {
        didSet {
            showImageView.layer.cornerRadius = 8
        }
    }

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func configure(with show: Show) {
        showName.text = show.name
        let url = show.image.medium
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.showImageView.image = UIImage(data: imageData)
                self?.activityIndicatorView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}


