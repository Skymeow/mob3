//
//  SessionTableViewCell.swift
//  CoursePlanner
//
//  Created by Sky Xu on 12/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var sessionName: UILabel!
    
    @IBAction func noteTapped(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
