//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 18/12/2020.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @State private var speechTranscript = ""
    @State private var isRecording = false
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                MeetingTimerView(speakers: scrumTimer.speakers, scrumColor: scrum.color, isRecording: isRecording)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            speechRecognizer.record(to: $speechTranscript)
            isRecording = true
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            speechRecognizer.stopRecording()
            isRecording = false
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60, transcript: speechTranscript)
            scrum.history.insert(newHistory, at: 0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
