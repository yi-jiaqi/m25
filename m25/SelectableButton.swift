//
//  SelectableButton.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.16.
//

import SwiftUI

enum ButtonType {
    case multipleText
    case singleText
    case externalLink
}

struct SelectableButton: View {
    let type: ButtonType
    let texts: [String] // 1–4 items for multi-text, or 1 item for single text
    let linkURL: URL?   // Only used for external link
    var onSelect: (() -> Void)? = nil
    @Binding var isSelected: Bool
    
    var body: some View {
        Group {
            switch type {
            case .multipleText:
                buttonMultipleTexts
            case .singleText:
                buttonSingleText
            case .externalLink:
                buttonExternalLink
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60) // ✅ consistent height
        .padding(.horizontal,12)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1)
        )
        .cornerRadius(10)
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            switch type {
            case .externalLink:
                if let url = linkURL {
                    UIApplication.shared.open(url)
                }
            default:
                isSelected.toggle()
                onSelect?() // ✅ triggers parent logic like image jump
            }
        }
    }
}

extension SelectableButton {
        // MARK: - Multi-text style (4 texts)
    private var buttonMultipleTexts: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(texts[safe: 0] ?? "")
                    .font(.xSmallHeadline)
                Text(texts[safe: 1] ?? "")
                    .font(.smallBodyText)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(texts[safe: 2] ?? "")
                    .font(.xSmallHeadline)
                Text(texts[safe: 3] ?? "")
                    .font(.smallBodyText)
            }
        }
        .foregroundColor(isSelected ? .white : .black)
    }
    
        // MARK: - Single-text style
    private var buttonSingleText: some View {
        Text(texts.first ?? "")
            .font(.xSmallHeadline)
            .foregroundColor(isSelected ? .white : .black)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
        // MARK: - External Link
    private var buttonExternalLink: some View {
        Text(texts.first ?? "")
            .font(.xSmallHeadline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 60) // consistent height + vertical centering
    }
    
    var backgroundColor: Color {
        switch type {
        case .externalLink:
            return .white
        default:
            return isSelected ? .black : .clear
        }
    }
    
    var borderColor: Color {
        switch type {
        case .externalLink:
            return .black
        default:
            return isSelected ? .clear : .black
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}


struct ButtonDemoView: View {
    @State private var isMonthlySelected = false
    @State private var isYearlySelected = true
    @State private var isSingleSelected = false
    
    var body: some View {
        VStack(spacing: 20) {
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
            
            SelectableButton(
                type: .singleText,
                texts: ["Your Current Membership"],
                linkURL: nil,
                isSelected: $isSingleSelected
            )
            
            SelectableButton(
                type: .externalLink,
                texts: ["Privacy Policy"],
                linkURL: URL(string: "https://minutiae-app.com/privacy"),
                isSelected: .constant(false)
            )
        }
        .background(Color.white)
    }
}

#Preview{
    ButtonDemoView().environmentObject(AppDataManager())
}
