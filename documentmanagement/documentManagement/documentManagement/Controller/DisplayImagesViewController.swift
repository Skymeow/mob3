//
//  DisplayImagesViewController.swift
//  documentManagement
//
//  Created by Sky Xu on 11/3/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class DisplayImagesViewController: UIViewController {
    var imgsFolder: URL?
    var imgNames = [URL](){
        didSet{
            DispatchQueue.main.async {
                self.imgsCollectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var imgsCollectionView: UICollectionView!
    
/** get an arr of all files that has the type of jpg or jpeg
 */
    func createImgNames(folder: URL) {
        let fm = FileManager.default
        let folder_url = try? fm.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        if let contents = folder_url {
            imgNames = contents.filter({ $0.absoluteString.contains(".jpg") || $0.absoluteString.contains(".jpeg")})
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        createImgNames(folder: imgsFolder!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DisplayImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imgsCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let eachImgUrl = imgNames[indexPath.row]
        print(eachImgUrl)
        cell.configureCell(collectionImage: eachImgUrl)
        
        return cell
    }
  
}
