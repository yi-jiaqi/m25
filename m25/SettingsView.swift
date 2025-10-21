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
        
        ScrollView {
            ButtonsBar(type: .setting, onClose: { dismiss() })
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "SETTING")
                    .padding(.top, 20)
                ToggleRow(label: "Location", isOn: $locationEnabled)
                ToggleRow(label: "Automatic Flash", isOn: $flashEnabled)
                ToggleRow(label: "Missed Moments Count", isOn: $missedCountEnabled)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "ACCOUNT")
                    .padding(.top, 20)
                
                Text("Your Email:")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Text("Delete Account:")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Text("Redeem")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "LINKS")
                    .padding(.top, 20)
                
                Text("minutiae Website")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Text("Shop")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Text("Gift")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .background(Color.black.ignoresSafeArea())
        
    }
    
}


    // MARK: - Subcomponent: Toggle Row
struct ToggleRow: View {
    var label: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .font(.bodyText)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 30)
    }
}


#Preview {
    SettingsView()
}
