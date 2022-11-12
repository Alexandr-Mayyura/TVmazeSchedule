//
//  DetailEpisodeViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    @IBOutlet var nameShowLabel: UILabel!
    @IBOutlet var nameEpisodeLabel: UILabel!
    @IBOutlet var showImageView: UIImageView! {
        didSet {
            showImageView.layer.cornerRadius = 8
        }
    }
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var episode: EpisodeInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        getValueForLabel()
        getValueForImageView()        
    }

    @IBAction func closedView() {
        dismiss(animated: true)
    }
    
    private func getValueForLabel() {
        nameShowLabel.text = episode.show.name
        nameEpisodeLabel.text = episode.name
        timeLabel.text = episode.airtime
//        daysLabel.text = episode.show.schedule.days.joined(separator: ", ")
        
        let summaryEpisode = episode.summary.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        summaryLabel.text = summaryEpisode
    }
    
    private func getValueForImageView() {
        NetworkManager.shared.fetchImage(from: episode.show.image.medium) { [weak self] result in
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
