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
    
    //have the searchKey here caz we customized our model property into something doesn't match with json key in the download file
    enum SearchKey: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImageURL = "zipped_image_url"
    }
    
//    init for struct
    init(collectionName: String, zippedImageURL: String) {
        self.collectionName = collectionName
        self.zippedImageURL = zippedImageURL
    }
    
//    init for decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchKey.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let zippedImageURL = try container.decode(String.self, forKey: .zippedImageURL)
        self.init(collectionName: collectionName, zippedImageURL: zippedImageURL)
    }
}




