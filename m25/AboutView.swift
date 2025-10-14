//
//  AboutView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation
import SwiftUI

struct ReadingView: View {
    @State private var selection: Int
    @Environment(\.dismiss) private var dismiss
    
    init(initialPage: Int) {
        _selection = State(initialValue: initialPage)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(hex: "1D1D1D").ignoresSafeArea()
            
            VStack(spacing: 0) {
                ButtonsBar(type: .reading, onClose: { dismiss() }) // make sure ButtonsBar has onClose
                Spacer().frame(height: 30)
                
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

#Preview {
    AboutView()
}
