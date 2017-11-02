//
//  TableViewCell.swift
//  documentManagement
//
//  Created by Sky Xu on 11/1/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import Foundation
import Zip

class TableViewCell: UITableViewCell {

    @IBAction func downloadTapped(_ sender: Any) {
        print("downloadTapped")
        do {
            let filePath = Bundle.main.url(forResource: "file", withExtension: "zip")
            let tempDir = FileManager.default.temporaryDirectory
            try Zip.unzipFile(filePath!, destination: tempDir, overwrite: true, password: "password", progress: { (progress) -> () in
                print(progress)
            })
        }
        catch {
            print("sorry, file unzip failed")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
