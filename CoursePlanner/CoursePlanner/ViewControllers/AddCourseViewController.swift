//
//  AddCourseViewController.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseTime: UITextField!
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let addedName = courseName.text,
            let addedTime = courseTime.text else { return }
        
        let addedCourse = Course(context: coreDataStack.privateContext)
        addedCourse.meetingTime = addedTime
        addedCourse.name = addedName
        coreDataStack.saveTo(context: coreDataStack.privateContext)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
