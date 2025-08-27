//
//  ImagenesSwiftDataApp.swift
//  ImagenesSwiftData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
@main
struct ImagenesSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                 //Paso 1.1,ponemos el modelo
                .modelContainer(for: PhotoModel.self)
        }
    }
}

