//
//  AddCourseViewController.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/6/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {
    
    var selectedCourse: Course?
    
    @IBOutlet weak var sessionTime: UITextField!
    
    @IBOutlet weak var sessionName: UITextField!
    
    @IBAction func saveSessionTapped(_ sender: UIButton) {
        
        guard let name = sessionName.text,
              let time = sessionTime.text else { return }
              self.selectedCourse?.setValue(name, forKey: "session")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
