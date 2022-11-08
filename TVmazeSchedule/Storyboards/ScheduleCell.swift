//
//  ScheduleCell.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class ScheduleCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var nameShowLabel: UILabel!
    
    @IBOutlet var nameEpisodeLabel: UILabel!
    
    @IBOutlet var timeProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
