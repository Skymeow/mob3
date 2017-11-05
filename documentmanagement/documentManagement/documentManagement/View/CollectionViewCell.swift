//
//  CollectionViewCell.swift
//  documentManagement
//
//  Created by Sky Xu on 11/5/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImgView: UIImageView!
    
    func configureCell(collectionImage: URL) {
        self.collectionImgView.image = UIImage(contentsOfFile: collectionImage.absoluteString)
    }
}
