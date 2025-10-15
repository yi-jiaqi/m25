    //
    //  ReadingView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.14.
    //

import Foundation
import SwiftUI

struct ReadingView: View {
    @State private var selection = 0
    @Environment(\.dismiss) private var dismiss
    
    init(initialPage: Int) {
        _selection = State(initialValue: initialPage)
    }
    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "FFFFFF").ignoresSafeArea()
            
            VStack(spacing: 0) {
                    // Fixed Top Bar
                ButtonsBar(type: .reading,onClose: { dismiss() })
                
                Spacer().frame(height: 30)
                
                    // TabView for Reading Pages
                TabView(selection: $selection) {
                    ReadingPage1().tag(0)
                    ReadingPage2().tag(1)
                    ReadingPage3().tag(2)
                    ReadingPage4().tag(3)
                    Color.clear.tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
    }
}

    // MARK: - Reading Pages

struct ReadingPage1: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Headline(type: .reading,heading: "MANIFESTO")
                Text("You are not your timeline.")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Text("""
Social media was supposed to keep us in touch with our friends but instead turned all of us into unpaid content creators, living under constant surveillance.
Facebook doesn’t want your memory, it wants your time.
minutiae is a response to our current moment, an anonymous, anti-social app made for one purpose alone — to record and celebrate the ordinary.
minutiae is not a normal app.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
            .padding(.top, 120)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReadingPage2: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "Rules")
                Text("Each day, one minute. No filters.")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("""
1. Once a day, at a random moment, all minutiae participants around the world receive simultaneous alerts.
2. You have exactly one minute to take your photo. When your minute is up, you can view your partner’s photo for that moment.
3. Once you capture your moment, you will have access to the full day’s timeline of everyone else who captured theirs.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: 512)
            .padding(.top, 120)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReadingPage3: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "the artists")
                Text("Martin Adolfsson & Daniel J Wilson")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("""
minutiae is an interdisciplinary art project, participatory performance, and a book.
Created by artists working across multiple media, including photography and film.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: 512)
            .padding(.top, 120)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReadingPage4: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "FAQ")
                Text("Why am I not getting alerts?")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("""
Notifications come at the same time for everyone around the world.
Make sure you have enabled Time Sensitive Notifications for minutiae.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: 512)
            .padding(.top, 120)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

    //#Preview {
    //    ReadingPageView(
    //        title: "MANIFESTO",
    //        content: "Social media was supposed to keep us in touch...",
    //        highlight: "You are not your timeline."
    //    )
    //}
