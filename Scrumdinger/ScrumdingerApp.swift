//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 18/12/2020.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @ObservedObject private var data = ScrumData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
