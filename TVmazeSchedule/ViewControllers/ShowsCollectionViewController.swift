//
//  ShowsCollectionViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class ShowsCollectionViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var episodes: [Show] = []
    private var filteredCharacter: [Show] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEpisodeSchedule()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        guard let detailShowVC = segue.destination as? DetailShowViewController else { return }
        indexPaths.forEach { indexPath in
            let show = isFiltering
            ? filteredCharacter[indexPath.item]
            : episodes[indexPath.item]
            detailShowVC.show = show
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
}

//MARK: CollectionView Data Source
extension ShowsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath)
        guard let cell = cell as? ShowCell else { return UICollectionViewCell() }
        
        let show = isFiltering
        ? filteredCharacter[indexPath.item]
        : episodes[indexPath.item]
        cell.configure(with: show)
        return cell
    }
}

// MARK: CollectionView Delegate
extension ShowsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 2 - 10, height: view.frame.height/2.5)
    }
}

//MARK: Network Methods
extension ShowsCollectionViewController {
    private func fetchEpisodeSchedule() {
        
        NetworkManager.shared.fetchShow(from: Link.showsURL.rawValue) { [weak self] result in
            switch result {
            case .success(let schedule):
                self?.episodes = schedule
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: Search Methods
extension ShowsCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacter = episodes.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        }
        
        collectionView.reloadData()
    }
}
