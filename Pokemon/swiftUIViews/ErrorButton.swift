//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import SwiftUI

struct ErrorButton: View {
    
    @State private var isPressed = false
    
    let onTap: (() -> Void)?
    let buttonTitle: String
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            Text(buttonTitle)
                .padding()
                .foregroundStyle(Color.black)
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(.easeInOut, value:  0.1)
        .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressed in
            withAnimation {
                self.isPressed = isPressed
            }
        }) {
            print("Long press!")
        }
        .frame(width: 110, height: 55,alignment: .center)
        .buttonStyle(PlainButtonStyle())
        .background(Color.blue.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
