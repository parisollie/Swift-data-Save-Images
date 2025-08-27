//
//  PhotoModel.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import Foundation
import SwiftData

//V-447,Paso 1.0,creamos el modelo.
@Model
class PhotoModel {
    // Para usar una imágen usamos el @attribute
    @Attribute(.externalStorage) var image : Data?
    
    var name : String
    
    //Le ponemos initi
    init(image: Data? = nil, name: String) {
        self.image = image
        self.name = name
    }
    
}
