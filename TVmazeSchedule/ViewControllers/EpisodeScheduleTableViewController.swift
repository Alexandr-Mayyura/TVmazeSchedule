//
//  EpisodScheduleTableViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import UIKit

class EpisodeScheduleTableViewController: UITableViewController {

    
    private var episodeInfo: [EpisodeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEpisodeSchedule()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodeInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        guard let cell = cell as? ScheduleCell else { return UITableViewCell() }
        let schedule = episodeInfo[indexPath.row]
        let timeZoneNetwork = schedule.show.network?.country.timezone
        let timeZoneWebChannel = schedule.show.webChannel?.country.timezone
        let time = dateFormattedFrom(
            string: schedule.airstamp,
            timeZone: (timeZoneNetwork ?? timeZoneWebChannel) ?? ""
    )
        
        cell.timeLabel.text = time
        cell.nameShowLabel.text = schedule.show.name
        cell.nameEpisodeLabel.text = schedule.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailEpisodSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailEpisodSegue" {
            guard let detailVC = segue.destination as? DetailEpisodeViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.episode = episodeInfo[indexPath.row]
        } else {
            guard let showsVC = segue.destination as? ShowsCollectionViewController else { return }
            showsVC.episodes = episodeInfo
        }
    }
    
    @IBAction func showAllShows(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "allShowsSegue", sender: nil)
    }
}

// MARK: Network Methods
extension EpisodeScheduleTableViewController {
    private func fetchEpisodeSchedule() {
        NetworkManager.shared.fetch([EpisodeInfo].self, from: Link.scheduleURL.rawValue) { [weak self] result in
            switch result {
            case .success(let schedule):
                self?.episodeInfo = schedule
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: DateFormatter
extension EpisodeScheduleTableViewController {
    func dateFormattedFrom(string: String, timeZone: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let data = dateFormatter.date(from: string) else { return "" }
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = "HH:mm"
        let dateForm = dateFormatter.string(from: data)
        return dateForm
    }
}
