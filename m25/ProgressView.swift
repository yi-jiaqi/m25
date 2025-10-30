//
//  ProogressView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation

import SwiftUI

struct ProgressView: View {
        // MARK: - Dynamic Values
    private let today = Date()
    private var completionDate: Date {
        Calendar.current.date(byAdding: DateComponents(year: 4, day: -20), to: today)!
    }
    private let capturedMoments = 89
    private let remainingMoments = 1212
    
        // MARK: - Date Formatting
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy, MMM d"
        return df
    }
    
        // MARK: - Body
    var body: some View {
        VStack(spacing: 20) { // Major group gap = 20
            
            Headline(type: .menu, heading: "Progress")
        
                VStack(spacing: 20) {
                    
                    VStack(spacing: 6) {
                        Text("Starting date")
                            .font(.smallHeadline)
                            .foregroundColor(.white)
                        Text(dateFormatter.string(from: today))
                            .font(.smallBodyText)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    VStack(spacing: 6) {
                        Text("Completion date")
                            .font(.smallHeadline)
                            .foregroundColor(.white)
                        Text(dateFormatter.string(from: completionDate))
                            .font(.smallBodyText)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    VStack(spacing: 6) {
                        Text("Captured moments")
                            .font(.smallHeadline)
                            .foregroundColor(.white)
                        Text("\(capturedMoments)")
                            .font(.smallBodyText)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    VStack(spacing: 6) {
                        Text("Remaining moments")
                            .font(.smallHeadline)
                            .foregroundColor(.white)
                        Text("\(remainingMoments)")
                            .font(.smallBodyText)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "1D1D1D"))
            
        }
        .padding(.horizontal,20)
    }
}

#Preview {
    ProgressView().environmentObject(AppDataManager())
}
