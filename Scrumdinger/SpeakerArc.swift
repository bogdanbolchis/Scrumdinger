//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 24/05/2021.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int
    
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        // The additional 1.0 degree is for visual separation between arc segments.
        let angle = Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
        print("startAngle: \(angle.degrees)")
        return angle
    }
    
    private var endAngle: Angle {
        // The subtracted 1.0 degree is for visual separation between arc segments.
        let angle = Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
        print("endAngle: \(angle.degrees)")
        return angle
    }

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.origin.x + rect.size.width / 2.0,
                             y: rect.origin.y + rect.size.height / 2.0)
        
        // The path(in:) function takes a CGRect parameter.
        // The coordinate system contains an origin in the lower left corner,
        // with positive values extending up and to the right.
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
