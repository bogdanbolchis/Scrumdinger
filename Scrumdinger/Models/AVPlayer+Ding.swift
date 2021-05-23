//
//  AVPlayer+Ding.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 23/05/2021.
//

import SwiftUI

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
