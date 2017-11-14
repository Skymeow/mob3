//
//  ViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    let stack = CoreDataStack.instance
    
    @IBOutlet weak var tableView: UITableView!
    var inventories = [Inventory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetch = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let result = try stack.viewContext.fetch(fetch)
            self.inventories = result
            self.tableView.reloadData()
            
        }catch let error {
            print(error)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toEdit", let destination = segue.destination as? EditInventoryViewController, let cellIndex = tableView.indexPathForSelectedRow?.row {
//            destination.inventoryName = inventories[cellIndex].name
//            destination.inventoryQuantity = "\(inventories[cellIndex].quantity)"
//            destination.inventoryDate = inventories[cellIndex].date
//        }
//    }
}


extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }
}

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        
        let item = inventories[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "x\(item.quantity) Date: \(item.date!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let invItem = inventories[row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let editViewController = storyBoard.instantiateViewController(withIdentifier: "editPage") as! EditInventoryViewController
        editViewController.inventoryName = invItem.name
        editViewController.inventoryQuantity = "\(invItem.quantity)"
        editViewController.inventoryDate = invItem.date
        navigationController?.pushViewController(editViewController, animated: true)
        
    }
}
