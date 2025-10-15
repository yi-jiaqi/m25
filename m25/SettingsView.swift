    //
    //  SettingsView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.15.
    //

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var locationEnabled = true
    @State private var flashEnabled = true
    @State private var missedCountEnabled = true
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                ButtonsBar(type: .setting,onClose: { dismiss() })
                
                Headline(type: .setting, heading: "Setting")
                
                ToggleRow(label: "Location", isOn: $locationEnabled)
                ToggleRow(label: "Automatic Flash", isOn: $flashEnabled)
                ToggleRow(label: "Missed Moments Count", isOn: $missedCountEnabled)
                
                
                VStack(alignment: .leading, spacing: 16) {
                    Headline(type: .setting, heading: "ACCOUNT")
                        .padding(.bottom, 6)
                    Divider().background(Color.white)
                    
                    Text("Your Email: ytp649296@gmail.com")
                        .font(.custom("Rubik-Light", size: 20))
                        .foregroundColor(.white)
                    
                    Text("Delete My Account")
                        .font(.custom("Rubik-Light", size: 20))
                        .foregroundColor(.white)
                    
                    Text("Redeem")
                        .font(.custom("Rubik-Light", size: 20))
                        .foregroundColor(.white)
                }
                
                    // MARK: - Links Section
                VStack(alignment: .leading, spacing: 16) {
                    Headline(type: .setting, heading: "LINKS")
                        .padding(.bottom, 6)
                    Divider().background(Color.white)
                    
                    Text("Minutiae Website")
                        .font(.custom("Rubik-Light", size: 20))
                        .foregroundColor(.white)
                    
                    Text("Shops & Gifts")
                        .font(.custom("Rubik-Light", size: 20))
                        .foregroundColor(.white)
                }
                
                    // MARK: - Footer
                Text("DO NOT DISTURB")
                    .font(.custom("Rubik-Medium", size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)
            }
        }
    }
}

#Preview {
    SettingsView()
}


    // MARK: - Subcomponent: Toggle Row
struct ToggleRow: View {
    var label: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Rubik-Light", size: 20))
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}
