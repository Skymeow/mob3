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
    
    var courses: [Course]?
    
    @IBOutlet weak var tableView: UITableView!
    
    func saveSessionToCourse(_ course: Course) {
        course.addToSessions(<#T##value: Session##Session#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch courses
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let course1 = Course(context: coreDataStack.privateContext)
        course1.name = "cs1"
        course1.meetingTime = "monday"
        
        let course2 = Course(context: coreDataStack.privateContext)
        course2.name = "cs2"
        course2.meetingTime = "tuesday"
        
        let course3 = Course(context: coreDataStack.privateContext)
        course3.name = "cs3"
        course3.meetingTime = "wedesday"
        
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        self.courses = [course1, course2, course3]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell", for: indexPath)
        cell.textLabel?.text = self.courses![indexPath.row].name
        cell.detailTextLabel?.text = self.courses![indexPath.row].meetingTime
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addSessionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addSession") as? addSessionViewController {
            addSessionVC.selectedCourse = self.courses?[indexPath.row]
            self.present(addSessionVC, animated: true)
        }
        
    }
}






