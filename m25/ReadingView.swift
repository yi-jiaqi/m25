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
                    ReadingPage5().tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
        .ignoresSafeArea(.all)
    }
}

    // MARK: - Reading Pages

//TODO: Finalize layout
struct ReadingPage1: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Headline(type: .reading,heading: "MANIFESTO")
//                Text("You are not your timeline.")
//                    .font(.headline)
//                    .foregroundColor(.black)
//                    .multilineTextAlignment(.center)
                Text("""
Social media was supposed to keep us in touch with our friends but has instead turned us all into unwitting monkeys filling out the world's longest consumer survey. 

Facebook doesn't want your money. It wants your time.

minutiae is a response to our current moment: an anonymous anti-social media app that forces its users to document the in-between moments of life. 

A collaboration between artist and participant that retrieves forgotten moments and celebrates the ordinary.

minutiae is not a normal app\n
§minutiae does not provide instant gratification\n
§minutiae is not interested in your data\n
§minutiae will not increase your efficiency\n
§minutiae is not a popularity contest\n
§minutiae is (let's be honest) not for everyone\n
minutiae is your automated self-portrait
""")
                .font(.bodyText)
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

                Headline(type: .reading,heading: "RULES")
//                Text("Each day, one minute. No filters.")
//                    .font(.headline)
//                    .foregroundColor(.black)
//                    .multilineTextAlignment(.center)
                Text("""
1. Once a day, at a random moment, all minutiae participants around the world receive a simultaneous alert.\n
﻿﻿﻿2. You have exactly one minute (an extra four minutes when you subscribe or pre-order the 360 Edition One Year Book) to respond to the notification and open your minutiae app.\n
3. Once you open the app, you have five seconds to take a photo of whatever is in front of you, there and then.\n
﻿﻿﻿4. If you miss a moment - which can happen - you will get a black square in place of your image.\n
﻿﻿﻿5. Once you capture your moment, you will have 60 seconds to explore previous moments - both your own and those of a random stranger you are matched with each day.\n
6. At the end of each 360-moment cycle (1 year), you will have the option to order a book with all your moments.\n
7. You'll also be able to download all your images as an archive at the end of the full 1440-moment cycle.
""")
                .font(.bodyText)
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
//TODO: Finalize layout

struct ReadingPage3: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "THE ARTISTS")
 
                Text("""
We created minutiae as an experiment: part artwork, part performance, part collective diary.\n
It grew from a shared fascination with the “in-between” — the unnoticed fragments that make up most of our lives.\n
Our inspiration comes from artists who worked with systems, time, and chance, including Sol LeWitt and On Kawara. minutiae carries those ideas into the digital present, using technology not to curate life but to reveal it.\n
The concept was born in 2014 while Martin Adolfsson and Daniel J Wilson were part of the New Museum’s art and tech incubator, NEW INC, in New York City. \n\nWhat began as a small experiment has evolved into a living archive of contemporary life created by strangers around the world. Together they record what simply exists — a portrait of the present, one minute at a time.\n
A bespoke version of the app and a Limited Edition book are included in Columbia University’s Rare Books and Manuscript Library collection. \n\nThe project has been exhibited at the New York, Los Angeles, and Tokyo Art Book Fairs, and featured in The Art Newspaper, Monocle, Wired, and the Financial Times.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                Text("Martin Adolfsson")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Text("""
Martin Adolfsson is a Swedish-born photographer and artist based in New York City.\n
 For more than two decades, his work has explored how technology and human behavior shape the ways we see, connect, and remember.\n
His first book, Suburbia Gone Wild (2013), examined the rise of the global middle class through staged photographs of model homes from Shanghai to Johannesburg. \n\nThe project revealed an uncanny sameness within our built environments—a realization that later shaped minutiae, where thousands of people unknowingly capture parallel moments in time from every corner of the world.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                Text("Daniel J Wilson")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Text("""
Daniel J Wilson is an artist and filmmaker whose work spans documentary, installation, and digital media.\n
 Before minutiae, he often sought to capture people in unguarded, natural states: driving a taxi on the night shift while recording passenger conversations, or experimenting with interactive forms of storytelling.\n
His experience as a filmmaker, balancing what appears on screen against what is left behind, led to an interest in what escapes documentation altogether. minutiae grew from that impulse—an attempt to preserve the fleeting, unscripted beauty of everyday life, the moments that usually go unseen.\n
He is currently a Ph.D. candidate studying cognitive neuroscience at the University of Toronto.
""")
                .font(.bodyText)
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

//TODO: Finalize layout

struct ReadingPage4: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                Headline(type: .reading,heading: "F.A.Q")

                Text("I’m not receiving any notifications. Is this a bug?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
All participants receive notifications at the exact same minute, no matter where they are in the world.

Because notifications are scheduled in UTC time, you might get two alerts on one day and none on another. 

However, over the full 1440-day cycle, every participant will capture the same total number of moments regardless of location.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("I only get alerts at night, so I can’t use the app.")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
During the 1440-day cycle, notifications are spread across every minute of the day. This means about 30% of your notifications will happen at night, no matter where in the world you are.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("Why can’t notifications be adjusted to my time zone?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
Good question! The main reason is that the minutiae cycle spans years, and during that time, you might move or travel between time zones.

Additionally, having time-zone-specific notifications would isolate participants by region, which goes against the project’s goal of connecting people globally.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("How can I avoid missing notifications?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
To make sure you see every notification, enable Time Sensitive Notifications for minutiae:

1. Go to your phone’s Settings -> Notifications -> minutiae.
2. Enable Time Sensitive Notifications so alerts can bypass settings like Focus mode.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("My settings are correct, so why am I still missing notifications?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
Notifications may be delivered silently in the following situations:

• Do Not Disturb mode is on.
• CarPlay is active.
• Do Not Disturb is enabled within the app.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("What can I do to always receive notifications?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
If you want to ensure notifications always come through, disable Do Not Disturb mode in the app.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("How do I see photos from other participants?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
When you capture your daily moment, you're automatically paired with another participant who captured their moment at the exact same time somewhere else in the world.

To view their photo:
• Tap the black box located beneath your captured moment on the timeline.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("What do the numbers on the grid mean?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
The grid represents the 1440 minutes in a day, which is the total number of moments you’ll capture over the 1440-day cycle of minutiae. Here’s how it works:

• Each square corresponds to one specific minute of the day.
• The top left corner is 00:00 (12:00 AM), the first minute of the day.
• The bottom right corner is 23:59 (11:59 PM), the last minute of the day.

Every time you capture a moment, the corresponding square on the grid is filled in. Over time, as you fill more squares, you’re building a complete record of moments spread across every minute of a day.

Once every square is filled, you’ve completed your minutiae journey—a unique snapshot of 1440 minutes across the span of 1440 days.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("If I order a book, will it include missed moments?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
It depends on the edition you choose:

• The 360 Edition (One Year Book) doesn’t include missed moments.
• The 1440 Edition (Four Year Book) includes all missed moments.

Ultimately, it’s up to you how engaged you want to be. But many participants find they treasure the moments they do capture far more than those they missed.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

                Text("Final Thoughts")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
minutiae is an art project, not a startup. Our goal is to help you create a personal, honest, and long-term self-portrait.
We understand that the project can feel frustrating in a world driven by instant gratification. But minutiae is designed to encourage patience and reflection. Many participants, after completing their first cycle, immediately start a second.

Remember: minutiae is a marathon—not a sprint.
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                Text("Still have questions?")
                    .font(.bodyText.weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Text("""
Feel free to email us at support@minutiae-app.org.
""")
                .font(.bodyText)
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


//TODO: USE PAYWALL FROM MINUTAE PROJECT

struct ReadingPage5: View {
    @State private var isMonthlySelected = false
    @State private var isYearlySelected = false
    @State private var isBenefactorSelected = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                    // 0. Headline
                Headline(type: .reading, heading: "Your Membership")
                
                    // 1. Intro text
                Text("""
minutiae is an independent art project funded by people like yourself (not outside investors).

Help us build the largest (and greatest) participatory art work in the world...and get some sweet benefits.

Martin, creator of minutiae
""")
                .font(.bodyText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
                    // MARK: - Supporter Section
                VStack(spacing: 16) {
                    Headline(type: .reading, heading: "Supporter")
                    
                    Text("""
Extra 4 minutes to capture
View your progress in shorter milestones
Privacy Mode
High-res version of your archive
Monthly summary of your journey & Discounted books and posters
""")
                    .font(.bodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    
                    SelectableButton(
                        type: .multipleText,
                        texts: ["$3.99/Month", "Cancel anytime", "", ""],
                        linkURL: nil,
                        isSelected: $isMonthlySelected
                    )
                    
                    SelectableButton(
                        type: .multipleText,
                        texts: ["$1.67/Month", "Billed yearly", "", ""],
                        linkURL: nil,
                        isSelected: $isYearlySelected
                    )
                    
                    Text("""
By subscribing, you agree to our Privacy Policy • Subscriptions auto-renew unless canceled at least 24 hours before the end of the current period.
""")
                    .font(.smallBodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                }
                
                    // MARK: - Participant Section
                VStack(spacing: 16) {
                    Headline(type: .reading, heading: "Participant")
                    
                    Text("""
One minute to capture
Low-res version of your archive
Full price Books and Posters
No soup for us...
""")
                    .font(.bodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    
                    SelectableButton(
                        type: .singleText,
                        texts: ["Your Current Membership"],
                        linkURL: nil,
                        isSelected: .constant(true)
                    )
                    
                    SelectableButton(
                        type: .singleText,
                        texts: ["Not Yet A Member?"],
                        linkURL: nil,
                        isSelected: .constant(true)
                    )
                    // This will lead to the paywall
                }
                
                    // MARK: - Add One Year Book Section
                VStack(spacing: 16) {
                    Headline(type: .reading, heading: "ADD: One Year Book")
                    
                    TabView {
                        Image("book_360_edition2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("book_360_edition1")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("book_360_edition6")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("book_360_edition7")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("book_360_edition8")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)

                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 330)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))

                    
                    Text("""
Includes all the benefits above.
Hard cover matte linen book.
80# GSM Ultra Smooth Paper.
Taxes + shipping included*
Ships worldwide.
""")
                    .font(.bodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    
                    SelectableButton(
                        type: .multipleText,
                        texts: ["$8.25/Month", "Billed yearly", "", ""],
                        linkURL: nil,
                        isSelected: $isBenefactorSelected
                    )
                    
                    Text("""
* Excludes UAE, HK, SG, AUS, NZ
Ships after a completed one year cycle.
""")
                    .font(.smallBodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                }
                
                    // MARK: - Benefactor Section
                VStack(spacing: 16) {
                    Headline(type: .reading, heading: "Benefactor")
                    
                    TabView {
                        Image("limited_edition1")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("limited_edition2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("limited_edition3")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        Image("limited_edition4")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .cornerRadius(10)
                            .padding(.top, 8)
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 330)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    
                    Text("""
As a benefactor, you provide additional support to the project. Your membership includes a numbered edition of the Limited Edition Book and much more.

The 2880-page Limited Edition book brings together timeless craftsmanship and modern technology. Each book is hand-bound by one of New York's best bookbinders.

The Limited Edition is part of the collection of the Rare Books and Manuscript Library at Columbia University in New York City.

Includes all the benefits in the supporter section.
Includes one Edition of the Limited Edition Book.
Appear as a benefactor in the Credits section.
""")
                    .font(.bodyText)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 80)
            .frame(maxWidth: 512)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
 

#Preview {
    ReadingView(initialPage: 3)
}
