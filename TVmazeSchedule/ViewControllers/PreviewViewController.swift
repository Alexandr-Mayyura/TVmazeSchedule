//
//  PreviewViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 09.11.2022.
//

import UIKit
import SpringAnimation

class PreviewViewController: UIViewController {
  
    @IBOutlet var firstMazeImageView: SpringImageView!
    @IBOutlet var secondMazeImageView: SpringImageView!
    @IBOutlet var scheduleButton: SpringButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animatedImageView(firstMazeImageView, "slideRight")
        animatedImageView(secondMazeImageView, "slideLeft")
        
        scheduleButton.animation = "fadeIn"
        scheduleButton.duration = 1.4
        scheduleButton.delay = 0.3
        scheduleButton.curve = "easeOut"
        scheduleButton.animate()
        
        scheduleButton.animation = "pop"
        scheduleButton.duration = 1
        scheduleButton.delay = 1.3
        scheduleButton.animate()
    }

    private func animatedImageView(_ imageView: SpringImageView, _ animation: String) {
        imageView.animation = animation
        imageView.duration = 1.4
        imageView.delay = 0.3
        imageView.curve = "easeOut"
        imageView.animate()
    }
}
