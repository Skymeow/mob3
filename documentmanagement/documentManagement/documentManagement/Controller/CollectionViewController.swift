//
//  ViewController.swift
//  documentManagement
//
//  Created by Sky Xu on 10/30/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import Foundation
import Zip
import Alamofire

class CollectionViewController: UIViewController {
    let fm = FileManager.default
    var progressStatus: Double?
    @IBOutlet weak var tableView: UITableView!
   
    var collections: [Collection] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.myjson.com/bins/17ge17")
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        session.dataTask(with: request) {(data, response, error) in
            guard let info = try? JSONDecoder().decode([Collection].self, from: data!) else { return }
            self.collections = info
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()

        
        
    }
}
// make collectionVC conform to DownloadTappedDelegate
extension CollectionViewController: UITableViewDataSource, DownloadTappedDelegate  {
/**
     1. pass the indexPath row of the cell in the parameter to get the zip string and name
     2. call the downloadZip function
 */
    func tapped(row: Int, _ sender: TableViewCell) {
        var eachCollection = collections[row]
        let name = eachCollection.collectionName
        let zipString = eachCollection.rawImageURL
        
    /**  1. Unzipping was finished
      2. Update model
     3. Reload collection view
     */
        downloadZipToCache(zipString: zipString, name: name, row: row) {
            url in
            print(url)
            let stringRawImg = URL(string: self.collections[row].rawImageURL)
            print(stringRawImg)
            let rawFolderName = stringRawImg!.lastPathComponent
            print(rawFolderName)
            let endIndex = rawFolderName.index(rawFolderName.endIndex, offsetBy: -4)
            let folderName = rawFolderName[..<endIndex]
            print(folderName)
            let cacheFileUrl = url.appendingPathComponent("\(folderName)/_preview.png")
            let allimgUrl = url.appendingPathComponent("\(folderName)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collections[row].previewImageURL = cacheFileUrl
                self.collections[row].unzippedURL = allimgUrl
                sender.progressbar.progress = Float(self.progressStatus!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    /**  1. download the zipfile to library/cashes
         2. unzip the file to temporary dir
         3. preview the thumb img
         4. show detail of all imgs
     */
//    part1
    func downloadZipToCache(zipString: String, name: String, row: Int, completion: @escaping(URL) -> Void) {
       let session = URLSession.shared
       let zipUrl = URL(string: zipString)
       var request = URLRequest(url: zipUrl!)
        request.httpMethod = "GET"
//        save to temp dir
        let temporaryDirectory = self.fm.temporaryDirectory
            //    for downloading zip file
            session.downloadTask(with: request) { (urlData, response , error) in
               let statusCode = (response as? HTTPURLResponse)!.statusCode
                if statusCode == 200 {
                    //    part2 unzip from tempdir
                    let urls = self.fm.urls(for: .cachesDirectory, in: .userDomainMask)
                    if let cacheDir: URL = urls.first {
                        print(cacheDir)
                        Zip.addCustomFileExtension("tmp")
                        do {
                            try Zip.unzipFile(urlData!, destination: cacheDir, overwrite: true, password: nil, progress: {(progress) -> () in
                                self.progressStatus = progress
                            })
                            
                            completion(cacheDir)
                        }
                        catch let error {
                            print("oh no \(error)")
                        }
                    }
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        let row = indexPath.row
        cell.row = row
        let eachCollection = collections[row]
        cell.nameLabel.text = eachCollection.collectionName
        let data = try? Data(contentsOf: eachCollection.previewImageURL)
        if let data = data {
            let img = UIImage(data: data)
            cell.zippedImg.image = img
        }
//        cell.progressbar.progress = Float(self.progressStatus!)
        return cell
    }

}

extension CollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imgCollection = collections[indexPath.row].unzippedURL
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let displayImagesViewController = storyBoard.instantiateViewController(withIdentifier: "toDisplay") as! DisplayImagesViewController
        displayImagesViewController.imgsFolder = imgCollection
        navigationController?.pushViewController(displayImagesViewController, animated: true)
    }
}

