//
//  LaundryLensApp.swift
//  LaundryLens
//
//  Created by Oluwatumininu Oguntola on 10/25/24.
//

import SwiftUI

@main
struct LaundryLensApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
