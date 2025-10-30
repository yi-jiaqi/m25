    //
    //  ButtonsBar.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.13.
    //

import SwiftUI

struct ButtonsBar: View {
    enum ButtonsBarType {
        case menu
        case grid
        case reading
        case setting
    }
    
    var type: ButtonsBarType
    var onClose: (() -> Void)? = nil
    var onInfo: (() -> Void)? = nil
    var onMenu: (() -> Void)? = nil
    @State private var showSettings = false
    
    var body: some View {
        HStack {
            switch type {
            case .menu:
                Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    onMenu?()   // ✅ menu → grid transition
                }) {
                    Image(systemName: "circle.grid.3x3.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .symbolRenderingMode(.monochrome)
                }
                
            case .grid:
                Button(action: {
                    onInfo?()   // ✅ info modal open
                }) {
                    Image(systemName: "i.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .symbolRenderingMode(.monochrome)
                        .background(
                            Circle()
                                .fill(Color.white) // The solid background color
                        )
                        .clipShape(Circle())
                }
                Spacer()
                Button(action: {
                    onMenu?()   // ✅ open menu from grid
                }) {
                    Image(systemName: "m.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .symbolRenderingMode(.monochrome)
                        .background(
                            Circle()
                                .fill(Color.white) // The solid background color
                        )
                        .clipShape(Circle())
                }
                
            case .reading:
                Button(action: {
                    onClose?()
                }) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .symbolRenderingMode(.monochrome)
                }
                Spacer()
            case .setting:
                Button(action: {
                    onClose?()
                }) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .symbolRenderingMode(.monochrome)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 42)
        .padding(.top, 80)
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity, alignment: .top)
        .symbolRenderingMode(.hierarchical)
        .fullScreenCover(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ButtonsBar(type: .menu)
        ButtonsBar(type: .grid)
        ButtonsBar(type: .reading)
    }
    .background(Color.white).environmentObject(AppDataManager())
}
