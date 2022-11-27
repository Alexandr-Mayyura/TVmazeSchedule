//
//  EpisodScheduleTableViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 07.11.2022.
//

import UIKit

class EpisodeScheduleTableViewController: UIViewController {
    
    let teamMenu = ["Профиль",  "Игры", "Кит лист", "Калькулятор", "Чек лист", "Заказы"]
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tickerCollectionView: UICollectionView!
    
    private var spinnerView = UIActivityIndicatorView()
    private var episodeInfo: [EpisodeInfo] = []
    private var isOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 95
        showSpinner(in: tableView)
        fetchEpisodeSchedule()
        tickerCollectionView.dataSource = self
        tickerCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isOn = true
        startScrolling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       isOn = false
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
    
    
    private  func startScrolling(){
        if isOn == true {
            let positionX = tickerCollectionView.contentOffset.x + 1
            UIView.animate(withDuration: 0.03, delay: 0, options: .curveEaseInOut, animations: { [weak self]() -> Void in
                self?.tickerCollectionView.contentOffset = CGPoint(x: positionX, y: 0)
            }) { [weak self] _ in
                self?.startScrolling()
            }
        }
    }
}

// MARK: - TableView data source
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

// MARK: - TableView delegate
extension EpisodeScheduleTableViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailEpisodeSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView data source
extension EpisodeScheduleTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tickerCell", for: indexPath)
        guard let cell = cell as? TickerCell else { return UICollectionViewCell() }
        let episode = episodeInfo[indexPath.item]
        cell.configure(with: episode)
        return cell
    }
    
}

// MARK: - CollectionView Delegate Flow Layout
extension EpisodeScheduleTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tickerCollectionView.bounds.width, height: tickerCollectionView.bounds.height)
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
                self?.tickerCollectionView.reloadData()
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
