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
    @State private var showDoNotDisturb = false
    @State private var selectedPage = -1
    
    var body: some View {
        VStack(spacing: 20) { // Major group gap = 20
            
            Headline(type: .menu, heading: "About")
            NavigationStack {
                
                VStack(spacing: 75) {
                    VStack(spacing: 30) {
                        Button("MANIFESTO") {
                            selectedPage = 0
                        }
                        Button("RULES") {
                            selectedPage = 1
                        }
                        Button("THE ARTISTS") {
                            selectedPage = 2
                        }
                        Button("FAQ") {
                            selectedPage = 3
                        }
                        Button("YOUR MEMBERSHIP") {
                            selectedPage = 4
                        }
                    }
                    .font(.smallHeadline)
                    .foregroundColor(.white)
                    .onChange(of: selectedPage) {
                            // small delay to prevent the “button unresponsive” issue
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            showReading = true
                        }
                    }
                    
                    VStack(spacing: 40) {
                        Button("DO NOT DISTURB") {
                            showDoNotDisturb = true
                        }
                        Text("DEMO")
                    }
                    .font(.smallHeadline)
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .background(Color(hex: "1D1D1D"))
                .fullScreenCover(isPresented: $showReading) {
                    ReadingView(initialPage: selectedPage)
                }
                .fullScreenCover(isPresented: $showDoNotDisturb) {
                    DoNotDisturbView()
                }
            }.padding(0)
        }
        .padding(.horizontal,20)
    }
}

#Preview {
    AboutView().environmentObject(AppDataManager())
}
