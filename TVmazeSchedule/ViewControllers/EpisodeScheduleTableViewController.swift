//
//  EpisodScheduleTableViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import UIKit

class EpisodeScheduleTableViewController: UITableViewController {

    private var spinnerView = UIActivityIndicatorView()
    private var episodeInfo: [EpisodeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(in: tableView)
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
        cell.configure(with: schedule)
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
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .gray
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true

        view.addSubview(spinnerView)
    }
}

// MARK: Network Methods
extension EpisodeScheduleTableViewController {
    private func fetchEpisodeSchedule() {
        NetworkManager.shared.fetchEpisode(from: Link.scheduleURL.rawValue) { [weak self] result in
            switch result {
            case .success(let schedule):
                self?.episodeInfo = schedule
                self?.tableView.reloadData()
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
