//
//  EpisodScheduleTableViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import UIKit

class EpisodeScheduleTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    private var spinnerView = UIActivityIndicatorView()
    private var episodeInfo: [EpisodeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 95
        showSpinner(in: tableView)
        fetchEpisodeSchedule()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailEpisodeSegue" {
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

// MARK: - Table view data source
extension EpisodeScheduleTableViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodeInfo.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        guard let cell = cell as? ScheduleCell else { return UITableViewCell() }
        let episode = episodeInfo[indexPath.row]
        cell.configure(with: episode)
        return cell
    }
}

// MARK: - Table view delegate
extension EpisodeScheduleTableViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailEpisodeSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Network Methods
extension EpisodeScheduleTableViewController {
    private func fetchEpisodeSchedule() {
        NetworkManager.shared.fetch(EpisodeInfo.self, from: Link.scheduleURL.rawValue) { [weak self] result in
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
