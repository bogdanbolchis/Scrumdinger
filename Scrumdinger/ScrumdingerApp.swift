//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 18/12/2020.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.data)
        }
    }
}
