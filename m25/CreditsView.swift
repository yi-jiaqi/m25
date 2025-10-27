//
//  CreditsView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation
import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 20) { // Major group gap = 20
            
            Headline(type: .menu, heading: "Credits")
            
            ScrollView{
                    // MARK: - Creators
                VStack(spacing: 10) { // Minor group gap = 10
                    Text("Creators")
                        .font(.smallHeadline)
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 4) {
                        Text("Martin Adolfsson")
                        Text("Daniel J Wilson")
                    }
                    .font(.smallBodyText)
                }
                
                    // MARK: - Supported By
                VStack(spacing: 10) {
                    Text("Supported By")
                        .font(.smallHeadline)
                        .multilineTextAlignment(.center)
                    
                        // Images (same height)
                    HStack(spacing: 10) {
                        Image("columbia")
                            .resizable()
                            .scaledToFit()
                        Image("konst")
                            .resizable()
                            .scaledToFit()
                        Image("newinc")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 60) // ensures same height
                    .padding(.horizontal)
                    
                        // Supporting text
                    VStack(spacing: 4) {
                        Text("Columbia University Libraries")
                        Text("RARE BOOK & MANUSCRIPT LIBRARY")
                        Text("Konstnärsnämnden")
                        Text("The Swedish Aers Grants Committee")
                        Text("New INC")
                    }
                    .font(.smallBodyText)
                    .multilineTextAlignment(.center)
                }
                
                    // MARK: - Benefactors
                VStack(spacing: 10) {
                    Text("Benefactors")
                        .font(.smallHeadline)
                    
                    VStack(spacing: 6) {
                        HStack {
                            Text("Anonymous")
                            Text("Matt Wan")
                            Text("Dean Bannon")
                        }
                        HStack {
                            Text("Anonymous")
                            Text("Stefan Herdinius")
                            Text("John Gaidimas")
                        }
                        HStack {
                            Text("Shawn. Michienzi")
                            Text("Carl Vikingsson")
                            Text("Colin J Graham")
                        }
                        HStack {
                            Text("Jay Rooney")
                            Text("Sandra Kulli")
                            Text("Nicole Sletterink")
                        }
                    }
                    .font(.smallBodyText)
                    .multilineTextAlignment(.center)
                }
                
                    // MARK: - minutiae Team
                VStack(spacing: 10) {
                    Text("minutiae Team")
                        .font(.smallHeadline)
                    
                    HStack(spacing: 20) {
                        Text("migge")
                        Text("Yoshikuni Kato")
                        Text("Jiaqi Yi")
                    }
                    .font(.smallBodyText)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
        }

    }
}

//#Preview {
//    AboutView()
//}
