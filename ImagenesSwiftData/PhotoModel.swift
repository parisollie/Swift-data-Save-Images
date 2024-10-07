//
//  PhotoModel.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import Foundation
import SwiftData

//Vid 447
@Model
class PhotoModel {
    @Attribute(.externalStorage) var image : Data?
    var name : String
    
    init(image: Data? = nil, name: String) {
        self.image = image
        self.name = name
    }
    
}
