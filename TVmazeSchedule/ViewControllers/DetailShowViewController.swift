//
//  DetailShowViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class DetailShowViewController: UIViewController {
    
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var nameShowLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var officialSiteTextView: UITextView!
    @IBOutlet var imageShowImageView: UIImageView! {
        didSet {
            imageShowImageView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        officialSiteTextView.dataDetectorTypes = .link
        officialSiteTextView.linkTextAttributes = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        getValueForLabel()
        getValueForImageView()
        
    }
    
    private func getValueForLabel() {
        switch show.rating.average {
        case 9...10:
            ratingLabel.text = "Rating: \(show.rating.average) \u{2B50}\u{2B50}\u{2B50}"
        case 8...9:
            ratingLabel.text = "Rating: \(show.rating.average) \u{2B50}\u{2B50}"
        case 7...8:
            ratingLabel.text = "Rating: \(show.rating.average) \u{2B50}"
        default:
            ratingLabel.text = "Rating: \(show.rating.average)"
        }
        nameShowLabel.text = show.name
        officialSiteTextView.text = show.officialSite
        typeLabel.text = "Type: \(show.type)"
        genresLabel.text = "Genre: \(show.genres.joined(separator: ", "))"
        
        let summaryEpisode = show.summary.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        
        summaryLabel.text = summaryEpisode
    }
    
    private func getValueForImageView() {
        NetworkManager.shared.fetchImage(from: show.image.medium) { [weak self] result in
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
