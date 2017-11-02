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
    var zippedImageURL: String
    var unzippedURL: String
    
    //have the searchKey here caz we customized our model property into something doesn't match with json key in the download file
    enum SearchKey: String, CodingKey {
        case collectionName = "collection_name"
        case unzippedURL = "zipped_images_url"
    }
    
//    init for struct
    init(collectionName: String, unzippedURL: String, zippedImageURL: String) {
        self.collectionName = collectionName
        self.unzippedURL = unzippedURL
        self.zippedImageURL = zippedImageURL
    }
    
//    init for decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchKey.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let unzippedURL = try container.decode(String.self, forKey: .unzippedURL)
        let zippedImageURL = "zippedImageURL"
        self.init(collectionName: collectionName, unzippedURL: unzippedURL, zippedImageURL: zippedImageURL)
    }
}




