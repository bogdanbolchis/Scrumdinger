//
//  ScrumProgressViewStyle.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 23/05/2021.
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var scrumColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .fill(scrumColor.accessibleFontColor)
                .frame(height: 20)
            ProgressView(configuration)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}
