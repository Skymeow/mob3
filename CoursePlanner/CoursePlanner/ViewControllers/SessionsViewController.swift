//
//  SessionsViewController.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/5/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController, UITableViewDelegate {
    
    let coreDataStack = CoreDataStack.instance
    var sessionName: String?
    var courseName: String?
    var selectedCourse: Course?
    let dataSource = TableViewDataSource(items: [])
    var sessions: [Session]? {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.items = self.sessions!
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.sessions = fetchAll(Session.self, route: .session(courseName: (self.selectedCourse?.name)!))
        self.tableView.dataSource = dataSource
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureCell = { (tableView, indexPath) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell") as! SessionTableViewCell
//            cell.delegate = self
            cell.sessionName.text = self.sessions![indexPath.row].name
            cell.sessionTime.text = self.sessions![indexPath.row].time
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if segue.identifier == "toAddSession" {
                let addSessionVC = segue.destination as! AddSessionViewController
                addSessionVC.selectedCourse = self.selectedCourse
            }
        }
    }
}
