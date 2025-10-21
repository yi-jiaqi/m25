//
//  AppDataManager 2.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.21.
//


import Foundation

class AppDataManager: ObservableObject {
    static let shared = AppDataManager()
    
    @Published var userState: UserState?

    private init() {
        loadUserData()
    }

    func loadUserData() {
        guard let url = Bundle.main.url(forResource: "testingUser", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load testingUser.json")
            return
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        
        guard let user = try? decoder.decode(TestingUser.self, from: data) else {
            print("❌ Failed to decode JSON")
            return
        }
        
        // Compute all runtime values
        let today = Date()
        let passedDays = Calendar.current.dateComponents([.day], from: user.startingDate, to: today).day ?? 0
        
        // Randomized boolean array of passedDays length
        let didCaptureMoments = (0..<passedDays).map { _ in Bool.random() }
        let capturedMoments = didCaptureMoments.filter { $0 }.count
        let missedMoments = didCaptureMoments.count - capturedMoments

        // Finishing dates
        let finishingDate = Calendar.current.date(byAdding: .day, value: 1440, to: user.startingDate)!
        let eachYearFinishingDate = (1...4).map { year in
            Calendar.current.date(byAdding: .day, value: 360 * year, to: user.startingDate)!
        }

        // Current year info
        let currentYearIndex = min(passedDays / 360, 3)
        let currentYearPassedDays = passedDays - currentYearIndex * 360

        // Each year progress (bounded 0–1)
        let eachYearProgress: [Double] = (0..<4).map { i in
            let progress = Double(passedDays - (i * 360)) / 360.0
            return max(0.0, min(progress, 1.0))
        }

        // Each year captured moments
        let eachYearCapturedMoments: [Int] = (0..<4).map { i in
            let start = i * 360
            let end = min((i + 1) * 360, passedDays)
            guard start < end else { return 0 }
            return didCaptureMoments[start..<end].filter { $0 }.count
        }

        // Combine
        let computedState = UserState(
            passedDays: passedDays,
            didCaptureMoments: didCaptureMoments,
            capturedMoments: capturedMoments,
            missedMoments: missedMoments,
            finishingDate: finishingDate,
            eachYearFinishingDate: eachYearFinishingDate,
            currentYearIndex: currentYearIndex,
            currentYearPassedDays: currentYearPassedDays,
            eachYearProgress: eachYearProgress,
            eachYearCapturedMoments: eachYearCapturedMoments
        )

        DispatchQueue.main.async {
            self.userState = computedState
        }
    }
}

// MARK: - Date Formatter Helper
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df
    }()
}