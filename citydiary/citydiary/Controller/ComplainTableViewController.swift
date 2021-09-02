//
//  ComplainTableViewController.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import CoreData
import UIKit

class ComplainTableViewController: UITableViewController {
    var dataManager: LocalComplainManager = LocalComplainManager.shared
    var complains: [Complain] { dataManager.fetchedResultsController?.fetchedObjects ?? [] }

    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        return label
    }()

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchAll(delegate: self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        label.text = "Nenhuma reclamação cadastrada"
        tableView.backgroundView = complains.count == 0 ? label : nil
        return complains.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComplainCellTableViewCell
        cell.prepare(with: dataManager.fetchedResultsController.object(at: indexPath))
        return cell
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
     }
     */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let complain = dataManager.fetchedResultsController.object(at: indexPath)
            dataManager.delete(complain)
        }
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComplainDetailSegue" {
            let vc = segue.destination as! ComplainDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            vc.complain = dataManager.fetchedResultsController.object(at: indexPath)
        }
    }
}

extension ComplainTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension ComplainTableViewController: LocalComplainManagerDelegate {
    func saveResult(succeful: Bool, error: String?) {
        if !succeful {
            // deu erro na operção de exclusão
            print(error ?? "Erro ao obter a mensagem")
        }
    }
}
