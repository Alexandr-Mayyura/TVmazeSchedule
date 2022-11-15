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
    
    @IBOutlet var officialSiteTextView: UITextView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var episode: EpisodeInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        officialSiteTextView.dataDetectorTypes = .link
        officialSiteTextView.linkTextAttributes = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        
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
        timeLabel.text = "Time: \(episode.airtime ?? "No time")"
        daysLabel.text = "Days: \(episode.show.schedule?.days.joined(separator: ", ") ?? "No day")"
        officialSiteTextView.text = episode.show.officialSite
        typeLabel.text = "Type: \(episode.type ?? "No type")"
        let summaryEpisode = episode.summary?.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        summaryLabel.text = summaryEpisode
    }
}

// MARK: Network Methods
extension DetailEpisodeViewController {
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
