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
                ToggleRow(label: "Location Service", isOn: $locationEnabled)
                ToggleRow(label: "Automatic Flash", isOn: $flashEnabled)
                ToggleRow(label: "Missed Moments Count", isOn: $missedCountEnabled)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "ACCOUNT")
                    .padding(.top, 20)
                
                Text("Account Email")
                    .font(.bodyText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                Text("Delete Account")
                    .font(.bodyTextBold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "LINKS")
                    .padding(.top, 20)
                
                Link(destination: URL(string: "https://minutiae-app.com")!) {
                    Text("minutiae Website")
                        .font(.bodyText)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                //TODO: This should link to TOS page.
                Link(destination: URL(string: "https://minutiae-app.com/tos")!) {
                    Text("Terms of Service")
                        .font(.bodyText)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                //TODO: This should link to website support page
                Link(destination: URL(string: "https://minutiae-app.com/support")!) {
                    Text("Contact Support")
                        .font(.bodyText)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .background(Color.black.ignoresSafeArea())
        .ignoresSafeArea(.all)
        
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
                .scaleEffect(0.8)
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    SettingsView().environmentObject(AppDataManager())
}
