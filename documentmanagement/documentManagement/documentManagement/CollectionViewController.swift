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
//    var collectionUrl: URL = URL(string: "string")! as URL
    
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
        let url = URL(string: "https://api.myjson.com/bins/17i2zn")
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        session.dataTask(with: request) {(data, response, error) in
            guard let info = try? JSONDecoder().decode([Collection].self, from: data!) else { return }
//            var zipImage = info[0].zippedImageURL
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
    func tapped(row: Int, collectionURL: URL) {
        var eachCollection = collections[row]
        let name = eachCollection.collectionName
        let zipString = eachCollection.rawImageURL
//        assign the cache url value we returned from the download function to a var
        let collectionPath = downloadZipToCache(zipString: zipString, name: name)
//        pass the cache url var to collection model
        eachCollection.unzippedURL = collectionPath!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    /**  1. download the zipfile to library/cashes
         2. unzip the file to temporary dir
         3. preview the thumb img
         4. show detail of all imgs
     */
//    part one
    func downloadZipToCache(zipString: String, name: String) -> URL? {
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
                    print("YOYOYOYOYOYO \(urlData)")
                    //    part2 unzip from tempdir
                    let urls = self.fm.urls(for: .cachesDirectory, in: .userDomainMask)
                    if let cacheDir: URL = urls.first {
                        print(cacheDir)
                        Zip.addCustomFileExtension("tmp")
//                        do {
                            let unzipPath = try? Zip.unzipFile(urlData!, destination: cacheDir, overwrite: true, password: nil, progress: {(progress) in
                                print(progress)
                            })
                            guard let urlPath = unzipPath else { return }
//                            return the urlPath of cache
                            return urlPath
//                        }
//                        catch let error {
//                            print("oh no \(error)")
//                        }
                    }
            }
        }.resume()
//        if urlPath is nil, return nil caz the url we return is optional
         return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        let row = indexPath.row
        cell.row = row
        let eachCollection = collections[row]
        cell.textLabel?.text = eachCollection.collectionName
        cell.unzippedCache = eachCollection.unzippedURL
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        //        pass in the delegate to cell
//        cell.delegate = self
//        let row = indexPath.row
//        cell.row = row
//
//        return cell
//    }
}


