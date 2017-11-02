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


class CollectionViewController: UIViewController {
    
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
        let url = URL(string: "https://api.myjson.com/bins/1165qr")
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

extension CollectionViewController: UITableViewDataSource, DownloadTappedDelegate  {
    
/**
     1. figure out the indexPath row of the cell tapped to get the zip string and name
     2. pass the value we get from row to the tapped function of delegate below
     3. call the downloadZip function
 */
    func tapped() {
        downloadZipToCache(zipString: <#T##String#>, name: <#T##String#>)
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
    func downloadZipToCache(zipString: String, name: String) -> Void {
       let session = URLSession.shared
       let zipUrl = URL(string: zipString)
       var request = URLRequest(url: zipUrl!)
        request.httpMethod = "GET"
       let fm = FileManager.default
        
//        save to cache dir
        let urls = fm.urls(for: .cachesDirectory, in: .userDomainMask)
        if let cacheDirectory: URL = urls.first {
            let cacheURL = cacheDirectory.appendingPathComponent(name)
            //        for downloading zip file
            session.downloadTask(with: request) { (data, response , error) in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
                if statusCode == 200 {
//                    copy the file from url we got from downloadTask to cache
                    do {
                        try fm.copyItem(at: data!, to: cacheURL)
                    }
                    catch {
                        print("sorry can't download")
                    }
                }
            }.resume()
        } else {
            print("download mission failed")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eachCollection = collections[indexPath.row]
        cell.textLabel?.text = eachCollection.collectionName
        let name = eachCollection.rawImageURL
        let zipString = eachCollection.rawImageURL
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eachCollection = collections[indexPath.row]

    }
}


