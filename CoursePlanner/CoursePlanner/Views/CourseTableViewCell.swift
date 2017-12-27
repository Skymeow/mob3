//
//  CourseTableViewCell.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

protocol passCourseDelegate: class {
    func tappedSession(_ sender: CourseTableViewCell)
    
    func tappedProject(_ sender: CourseTableViewCell)
}

class CourseTableViewCell: UITableViewCell {
    
    var selectedCourse: Course?
    weak var delegate: passCourseDelegate?
    @IBOutlet weak var courseTime: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    @IBAction func sessionTapped(_ sender: UIButton) {
        delegate?.tappedSession(self)
    }
    
    @IBAction func projectTapped(_ sender: UIButton) {
        delegate?.tappedProject(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
