//
//  ViewController.swift
//  documentManagement
//
//  Created by Sky Xu on 10/30/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.myjson.com/bins/1165qr")
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
        }.resume()
    }
}


