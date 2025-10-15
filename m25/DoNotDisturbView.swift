//
//  DoNotDisturbView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.15.
//

import SwiftUI
import HGCircularSlider

struct DoNotDisturbView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var activeDoNotDisturb = true
    @State private var flashEnabled = true
    @State private var missedCountEnabled = true
    
    var body: some View {
        
        ScrollView {
            ButtonsBar(type: .setting, onClose: { dismiss() })
            VStack(alignment: .leading, spacing: 20) {
                Headline(type: .setting, heading: "DO NOT DISTURB")
                    .padding(.top, 20)
                ToggleRow(label: "Active Do Not Disturb", isOn: $activeDoNotDisturb)
                
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
        }
        .background(Color.black.ignoresSafeArea())
        
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
