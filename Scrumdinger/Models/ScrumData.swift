//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Bogdan Bolchis on 24/05/2021.
//

import Foundation

class ScrumData: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static var documentDirectory: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find .documentDirectory")
        }
    }
    
    private static var fileURL: URL {
        return documentDirectory.appendingPathComponent("scrums.data")
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
                #endif
                return
            }
            guard let decodedDailyScrums = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
                fatalError("Can't decode saved scrum data.")
            }
            DispatchQueue.main.async {
                self?.scrums = decodedDailyScrums
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrums = self?.scrums else { fatalError("Self out of scope")}
            guard let data = try? JSONEncoder().encode(scrums) else { fatalError("Error encoding data.")}
            do {
                try data.write(to: Self.fileURL)
            } catch {
                fatalError("Can't write to \(Self.fileURL).")
            }
        }
    }
}
