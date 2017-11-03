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
    func tapped(row: Int, collectionURL: URL)
}

class TableViewCell: UITableViewCell {
    var row: Int = 0
    var unzippedCache: URL = URL(string: "URL")!
    @IBOutlet weak var zippedImg: UIImageView!
    //    instantiate the delegate in the sender
    weak var delegate: DownloadTappedDelegate?
    
    @IBAction func downloadTapped(_ sender: Any) {
        print("downloadTapped")
        //  instantiate a var to the value of unzippedURL of Collection model
//        var unzippedCache = Collection[self.row]
        //  call the delegate when the button is tapped
        delegate?.tapped(row: self.row, collectionURL: unzippedCache)

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
