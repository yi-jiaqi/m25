    //
    //  DoNotDisturbView.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.15.
    //

import SwiftUI
import HGCircularSlider
//QUESTION: HOW TO SETUP STYLE LIKE THE OLD VERSION

struct DoNotDisturbView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var activeDoNotDisturb = true
    
        // ⏰ Bindings for start & end times (in seconds)
    @State private var bedtime: CGFloat = 23 * 60 * 60  // 11:00 PM
    @State private var wake: CGFloat = 7 * 60 * 60      // 7:00 AM
    
        // Formatter for labels
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df
    }()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            ButtonsBar(type: .setting, onClose: { dismiss() })
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                        // Header
                    Headline(type: .setting, heading: "DO NOT DISTURB")
                        .padding(.top, 10)
                    
                        // Toggle
                    ToggleRow(label: "Active Do Not Disturb", isOn: $activeDoNotDisturb)
                    
                        // Labels for Bedtime & Wake
                    HStack {
                        VStack {
                            Text("Bedtime")
                                .font(.bodyText)
                                .foregroundColor(.white)
                            Text(formatTime(bedtime))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack {
                            Text("Wake")
                                .font(.bodyText)
                                .foregroundColor(.white)
                            Text(formatTime(wake))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                        // 👇 Circular Clock component
                    HStack{
                        CircularClockView(startValue: $bedtime, endValue: $wake)
                            .frame(width: 280, height: 280)
                            .padding(.top, 40)
                            .disabled(!activeDoNotDisturb) // disable when switch is off
                        .opacity(activeDoNotDisturb ? 1 : 0.5)}.frame(maxWidth: .infinity, alignment: .center)
                    
                        // Confirm button
                    Button {
                        saveSettings()
                        dismiss()
                    } label: {
                        Text("CONFIRM")
                            .font(.smallHeadline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 30)
                }
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }}
        .background(Color.black.ignoresSafeArea())
    }
    
        // Helper to format seconds → time string
    private func formatTime(_ seconds: CGFloat) -> String {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(seconds))
        return formatter.string(from: date)
    }
    
    private func saveSettings() {
        print("Saved — DND:", activeDoNotDisturb, "Bedtime:", bedtime, "Wake:", wake)
    }
}

#Preview {
    DoNotDisturbView()
}


struct CircularClockView: UIViewRepresentable {
    @Binding var startValue: CGFloat
    @Binding var endValue: CGFloat
    var maximumValue: CGFloat = 24 * 60 * 60 // one full day in seconds
    
    func makeUIView(context: Context) -> RangeCircularSlider {
        let slider = RangeCircularSlider()
        slider.maximumValue = maximumValue
        slider.startThumbImage = UIImage(named: "Bedtime")
        slider.endThumbImage = UIImage(named: "Wake")
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: RangeCircularSlider, context: Context) {
        uiView.startPointValue = startValue
        uiView.endPointValue = endValue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: CircularClockView
        init(_ parent: CircularClockView) { self.parent = parent }
        
        @objc func valueChanged(_ sender: RangeCircularSlider) {
            parent.startValue = sender.startPointValue
            parent.endValue = sender.endPointValue
        }
    }
}
