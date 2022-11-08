//
//  DatailEpisodeViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class DatailEpisodeViewController: UIViewController {
    
    
    @IBOutlet var nameShowLAbel: UILabel!
    
    @IBOutlet var nameEpisodeLabel: UILabel!
    
    @IBOutlet var showImageView: UIImageView!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var daysLabel: UILabel!
    
    @IBOutlet var discriprionLabel: UILabel!
    
    @IBOutlet var activityIndicarotView: UIActivityIndicatorView!
    
    var episode: EpisodeInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicarotView.startAnimating()
        activityIndicarotView.hidesWhenStopped = true
        nameShowLAbel.text = episode.show.name
        nameEpisodeLabel.text = episode.name
        timeLabel.text = episode.show.schedule?.time
        daysLabel.text = episode.show.schedule?.days?.joined(separator: ", ")
        
        let summary = episode.summary?.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        discriprionLabel.text = summary
         
        NetworkManager.shared.fetchImage(from: episode.show.image?.medium) { [weak self] result in
            
            switch result {
            case .success(let imageData):
                self?.showImageView.image = UIImage(data: imageData)
                self?.activityIndicarotView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }

    
    @IBAction func closedView() {
        dismiss(animated: true)
    }
    

}
