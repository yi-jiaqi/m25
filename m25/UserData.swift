//
//  UserData.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.21.
//

import Foundation

struct TestingUser: Codable {
    let startingDate: Date
}

struct UserState {
    let startingDate: Date 
    let passedDays: Int
    let didCaptureMoments: [Bool]
    let capturedMoments: Int
    let missedMoments: Int
    let finishingDate: Date
    let eachYearFinishingDate: [Date]
    let currentYearIndex: Int
    let currentYearPassedDays: Int
    let eachYearProgress: [Double]
    let eachYearCapturedMoments: [Int]
}
