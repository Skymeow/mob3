//
//  AddCourseViewController.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/6/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {
    
    let coreDataStack = CoreDataStack.instance
    var selectedCourse: Course?
    
    @IBOutlet weak var sessionTime: UITextField!
    @IBOutlet weak var sessionName: UITextField!
    
    @IBAction func saveSessionTapped(_ sender: UIButton) {
        let newSession =  Session(context: coreDataStack.privateContext)
        guard let name = sessionName.text,
              let time = sessionTime.text else { return }
              newSession.name = name
              newSession.time = time
              newSession.courseName = selectedCourse?.name
//              self.selectedCourse?.addToSessions(newSession)
              coreDataStack.saveTo(context: coreDataStack.privateContext)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}
