//
//  ErrorView.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import SwiftUI

struct ErrorView: View {
    
    let error: String
    var title: String = "Retry"
    
    var retryAction: (() -> Void)?
    
    var body: some View {
        VStack {
            PokeballView(size: .init(width: 70, height: 70), kCons: 4, kInnerMultipler: 0.7, isError: true)
                .padding()
            Text(error)
                .foregroundColor(.black)
                .font(.title2)
                .padding()
                .frame(alignment: .center)
            ErrorButton(onTap: retryAction, buttonTitle: title)
        }
        .background(Color.primary)
    }
}

#Preview {
    ErrorView(error: "Something Went Wrong!")
}
