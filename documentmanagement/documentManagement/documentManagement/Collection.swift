//
//  Collection.swift
//  documentManagement
//
//  Created by Sky Xu on 10/30/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    var collectionName: String
    var rawImageURL: String
    var unzippedURL: URL
    var previewImageURL: URL
    
    //have the searchKey here caz we customized our model property into something doesn't match with json key in the download file
    enum SearchKey: String, CodingKey {
        case collectionName = "collection_name"
        case rawImageURL = "zipped_images_url"
    }
    
//    init for struct
    init(collectionName: String, unzippedURL: URL, rawImageURL: String, previewImageURL: URL) {
        self.collectionName = collectionName
        self.unzippedURL = unzippedURL
        self.rawImageURL = rawImageURL
        self.previewImageURL = previewImageURL
    }
    
//    init for decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchKey.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let rawImageURL = try container.decode(String.self, forKey: .rawImageURL)
        let unzippedURL = URL(string: "unzippedURL")
        let previewImageURL = URL(string: "unzippedURL")
        self.init(collectionName: collectionName, unzippedURL: unzippedURL!, rawImageURL: rawImageURL, previewImageURL: previewImageURL!)
    }
}




