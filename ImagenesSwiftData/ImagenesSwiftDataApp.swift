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
            //Vid 447
                .modelContainer(for: PhotoModel.self)
        }
    }
}

