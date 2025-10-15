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
Social media was supposed to keep us in touch with our friends but has instead turned us all into unwitting monkeys filling out the world's longest consumer survey. 

Facebook doesn't want your money. It wants your time.

minutiae is a response to our current moment: an anonymous anti-social media app that forces its users to document the in-between moments of life. 

A collaboration between artist and participant that retrieves forgotten moments and celebrates the ordinary.

minutiae is not a normal app
§minutiae does not provide instant gratification
§minutiae is not interested in your data
§minutiae will not increase your efficiency
§minutiae is not a popularity contest
§minutiae is (let's be honest) not for everyone
minutiae is your automated self-portrait
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
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
1. Once a day, at a random moment, all minutiae participants around the world receive a simultaneous alert.
 ﻿﻿﻿2. You have exactly one minute (an extra four minutes when you subscribe or pre-order the 360 Edition One Year Book) to respond to the notification and open your minutiae app.
 3. Once you open the app, you have five seconds to take a photo of whatever is in front of you, there and then.
 ﻿﻿﻿4. If you miss a moment - which can happen - you will get a black square in place of your image.
 ﻿﻿﻿5. Once you capture your moment, you will have 60 seconds to explore previous moments - both your own and those of a random stranger you are matched with each day.
 6. At the end of each 360-moment cycle (1 year), you will have the option to order a book with all your moments.
 7. You'll also be able to download all your images as an archive at the end of the full 1440-moment cycle.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReadingPage3: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "the artists")
 
                Text("""
minutiae is an interdisciplinary art project, participatory performance, and a book.
Created by artists working across multiple media, including photography and film.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                Text("Martin Adolfsson")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("""
Martin Adolfsson is a Swedish-born photographer and artist based in New York City.
Adolfsson is the founder of InsaneLittleProjects, a digital studio focusing on projects at the intersection of Photography, Technology, and Behavior.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                Text("MDaniel J Wilson")
                    .font(.custom("Rubik-Medium", size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("""
Daniel J Wilson is an artist and filmmaker working across multiple media. 
He is currently a Ph.D. candidate studying cognitive neuroscience at the University of Toronto.
""")
                .font(.custom("Rubik-Light", size: 24))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
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
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
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
