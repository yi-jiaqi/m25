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
    }
    
    var type: ButtonsBarType
    var onClose: (() -> Void)? = nil   // 👈 Added closure
    var body: some View {
        HStack {
            switch type {
            case .menu:
                Button(action: {
                        // Placeholder action for gearshape
                }) {
                    Image(systemName: "gearshape.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                        // Placeholder action for m.circle
                }) {
                    Image(systemName: "circle.grid.3x3.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            
                case .grid:
                Button(action: {
                        // Placeholder action for i.circle
                }) {
                    Image(systemName: "i.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                Spacer()
                Button(action: {
                        // Placeholder action for apps.ipad
                }) {
                    Image(systemName: "m.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
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
                }
                Spacer()
            }
        }
        .padding(.horizontal, 42)
        .padding(.top, 80)
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity, alignment: .top)
        .symbolRenderingMode(.hierarchical)
    }
}

#Preview {
    VStack(spacing: 20) {
        ButtonsBar(type: .menu)
        ButtonsBar(type: .grid)
        ButtonsBar(type: .reading)
    }
    .background(Color.white)
}
