//
//  EditInventoryViewController.swift
//  MakeInventory
//
//  Created by Sky Xu on 11/13/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import Foundation
class EditInventoryViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    var inventoryName: String?
    var inventoryQuantity: String?
    var inventoryDate: String?
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var quantitylabel: UITextField!
    
    @IBOutlet weak var dateLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.placeholder = inventoryName ?? "Eggs"
        quantitylabel.placeholder = inventoryQuantity ?? "2"
        dateLabel.placeholder = inventoryDate ?? "1994"
    }
    
    @IBAction func editInventoryTapped(_ sender: UIButton) {
        let inv = Inventory(context: coreDataStack.privateContext)
        inv.name = nameLabel.text
        inv.date = dateLabel.text
        inv.quantity = Int64(quantitylabel.text!)!
        
        coreDataStack.saveTo(context: coreDataStack.privateContext)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
