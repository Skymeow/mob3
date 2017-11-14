//
//  Networking.swift
//  documentManagement
//
//  Created by Sky Xu on 11/2/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

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
