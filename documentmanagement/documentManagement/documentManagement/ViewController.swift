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

class ViewController: UIViewController {

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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
//    func saveResourceToTempDict(imageString: String) -> Void {
//        let url = URL(string: imageString)
//        let session = URL
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eachCollection = collections[indexPath.row]
        if eachCollection.collectionName != nil {
            cell.textLabel?.text = eachCollection.collectionName
            print(eachCollection.collectionName)
        }
        if eachCollection.zippedImageURL != nil {
            print(eachCollection.zippedImageURL)
            do {
                let url = URL(string: eachCollection.zippedImageURL)
                let unzipDict = try Zip.quickUnzipFile(url!)
                print(unzipDict)
            }
            catch {
                print("sorry, file unzip failed")
            }
        }
        
        return cell
    }
}

