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

//declare the protocol in the sender, pass in the tapped function to make sure the button is tapped in cell
protocol DownloadTappedDelegate: class {
    func tapped(row: Int)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    var row: Int = 0
//    var unzippedCache: URL? {
//        didSet {
//            if let image = unzippedCache?.absoluteString {
//                zippedImg.image = UIImage(contentsOfFile: image)
//            }
//          
//        }
//    }
    @IBOutlet weak var zippedImg: UIImageView!
    //    instantiate the delegate in the sender
    weak var delegate: DownloadTappedDelegate?
    
    @IBAction func downloadTapped(_ sender: Any) {
        print("downloadTapped")
        //  call the delegate when the button is tapped
        delegate?.tapped(row: self.row)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
