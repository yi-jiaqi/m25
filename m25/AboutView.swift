    //
    //  AboutView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.14.
    //

import Foundation
import SwiftUI

struct AboutView: View {
    @State private var showReading = false
    @State private var selectedPage = 0
    
    var body: some View {
        VStack(spacing: 20) { // Major group gap = 20
            
            Headline(type: .menu, heading: "About")
            NavigationStack {
                
                VStack(spacing: 60) {
                    VStack(spacing: 30) {
                        Button("MANIFESTO") {
                            selectedPage = 0
                            showReading = true
                        }
                        Button("RULES") {
                            selectedPage = 1
                            showReading = true
                        }
                        Button("THE ARTISTS") {
                            selectedPage = 2
                            showReading = true
                        }
                        Button("FAQ") {
                            selectedPage = 3
                            showReading = true
                        }
                        Text("YOUR MEMBERSHIP")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    
                    VStack(spacing: 40) {
                        Text("DO NOT DISTURB")
                        Text("DEMO")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .background(Color(hex: "1D1D1D"))
                .fullScreenCover(isPresented: $showReading) {
                    ReadingView(initialPage: selectedPage)
                }
            }
        }
        .padding(.horizontal,20)
    }
}

#Preview {
    AboutView()
}
