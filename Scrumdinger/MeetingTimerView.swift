//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 24/05/2021.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    var scrumColor: Color
    private var currentSpeaker: String { speakers.first(where: { !$0.isCompleted })?.name ?? "Someone" }
    let isRecording: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: 24, antialiased: true)
            VStack {
                Text(currentSpeaker)
                    .font(.title)
                Text("is speaking")
                Image(systemName: isRecording ? "mic" : "mic.slash")
                    .font(.title)
                    .padding(.top)
                    .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
            }
            .accessibilityElement(children: .combine)
            .foregroundColor(scrumColor.accessibleFontColor)
            ForEach(speakers) { speaker in
                if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                    SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                        // Rotating the arc moves the 0-degree angle to the 12 o’clock position and so on.
                        .rotation(Angle(degrees: -90))
                        .stroke(Color.red, lineWidth: 12)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers = [ScrumTimer.Speaker(name: "Kim", isCompleted: false),
                           ScrumTimer.Speaker(name: "Bill", isCompleted: false),
                           ScrumTimer.Speaker(name: "George", isCompleted: false),]
    static var previews: some View {
        MeetingTimerView(speakers: speakers, scrumColor: Color("Design"), isRecording: true)
    }
}
