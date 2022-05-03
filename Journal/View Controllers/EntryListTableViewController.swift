//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Harrison Kleiman on 5/2/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journal?.entries.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        // Configure the cell...
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = entry.title

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let journal = journal,
              let destination = segue.destination as? EntryDetailViewController else { return }
        
        if segue.identifier == "showEntry" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entryToSend = journal.entries[indexPath.row]
            destination.journal = journal
            destination.entry = entryToSend
        } else if segue.identifier == "createNewEntry" {
            destination.journal = journal
        }
    }
}
