//
//  DetailShowViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class DetailShowViewController: UIViewController {
    
    @IBOutlet var nameShowLabel: UILabel!
    @IBOutlet var officialSiteLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var imageShowImageView: UIImageView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        getValueForLabel()
        getValueForImageView()
    }
    
    private func getValueForLabel() {
        nameShowLabel.text = show.name
        officialSiteLabel.text = show.officialSite
        typeLabel.text = show.type
        
        let summaryEpisode = show.summary?.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        
        summaryLabel.text = summaryEpisode ?? "No summary"
    }
    
    private func getValueForImageView() {
        NetworkManager.shared.fetchImage(from: show.image?.medium) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageShowImageView.image = UIImage(data: imageData)
                self?.activityIndicatorView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    

    @IBAction func dismissView() {
        dismiss(animated: true)
    }
    

}
