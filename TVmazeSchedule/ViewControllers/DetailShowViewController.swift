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
        getValueForImageView()
        getValueForLabel()
    }
    
    private func getValueForLabel() {
        
        nameShowLabel.text = show.name
        officialSiteTextView.text = show.officialSite ?? "Not link"
        typeLabel.text = "Type: \(show.type ?? "not type")"
        genresLabel.text = "Genre: \(show.genres?.joined(separator: ", ") ?? "not genre")"
//
        let summaryEpisode = show.summary?.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        summaryLabel.text = summaryEpisode
        
        if let rating = show.rating?.average {
            switch rating {
            case 9...10:
                ratingLabel.text = "Rating: \(rating) \u{2B50}\u{2B50}\u{2B50}"
            case 8...9:
                ratingLabel.text = "Rating: \(rating) \u{2B50}\u{2B50}"
            case 7...8:
                ratingLabel.text = "Rating: \(rating) \u{2B50}"
            default:
                ratingLabel.text = "Rating: \(rating)"
            }
        } else {
            ratingLabel.text = "Rating: not rating"
        }
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
