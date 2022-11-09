//
//  ShowsCollectionViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 08.11.2022.
//

import UIKit

class ShowsCollectionViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var episodes: [EpisodeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        guard let detailShowVC = segue.destination as? DetailShowViewController else { return }
        indexPaths.forEach { indexPath in
            detailShowVC.show = episodes[indexPath.item].show
        }
    }
}

//MARK: CollectionView Data Source
extension ShowsCollectionViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCell", for: indexPath)
         guard let cell = cell as? ShowCell else { return UICollectionViewCell() }
         let episode = episodes[indexPath.item]
         cell.configure(with: episode)
        return cell
    }
}

// MARK: CollectionView Delegate
extension ShowsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 2 - 10, height: view.frame.height/2.5)
    }
}


