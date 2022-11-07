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
        let cell = tableView.dequeueReusableCell(withIdentifier: "sheduleCell", for: indexPath)
        let schedule = episodeInfo[indexPath.row]
        var content = cell.defaultContentConfiguration()
        let time = String().dateFormattedFrom(string: schedule.airstamp)
        content.text = time
        content.secondaryText = schedule.show?.name
        
        cell.contentConfiguration = content

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

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

extension String {
    func dateFormattedFrom(string: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let data = dateFormatter.date(from: string) else { return "" }
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        dateFormatter.dateFormat = "HH:mm"
        let dateForm = dateFormatter.string(from: data)
        return dateForm
    }
}
