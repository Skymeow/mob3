//
//  ViewController.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/4/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    
    let coreDataStack = CoreDataStack.instance
    var courses: [Course]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // fetch courses
        self.courses = fetchAll(Course.self, route: .course)
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell", for: indexPath) as! CourseTableViewCell
        cell.delegate = self
        cell.courseName.text = self.courses![indexPath.row].name
        cell.courseTime.text = self.courses![indexPath.row].meetingTime
        cell.selectedCourse = self.courses![indexPath.row]
        
        return cell
    }
}

extension CoursesViewController: passCourseDelegate {
    
    func tappedSession(_ sender: CourseTableViewCell) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "sessionsVC") as! SessionsViewController
        vc.selectedCourse = sender.selectedCourse
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tappedProject(_ sender: CourseTableViewCell) {
        
    }
}




