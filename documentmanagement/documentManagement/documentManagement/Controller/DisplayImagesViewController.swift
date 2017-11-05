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
    
    //        create a for loop to display arr of imgs in the collection grid view
    func createImgNames(folder: URL) {
        for i in 1..<10 {
            let pathDir = "\(i)" + ".jpg"
            let eachImgName = folder.appendingPathComponent(pathDir)
            imgNames.append(eachImgName)
        }
        print(imgNames)
        DispatchQueue.main.async {
            self.imgsCollectionView.reloadData()
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
