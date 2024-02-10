//
//  PokeBall.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import SwiftUI

struct PokeballView: View {
    
//    let size: CGSize = .init(width: 200, height: 200)
//    let kCons: CGFloat = 8
//    let kInnerMultipler: CGFloat = 0.7
    
    let size: CGSize
    let kCons: CGFloat
    let kInnerMultipler: CGFloat
    let isError: Bool
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black, lineWidth: kCons * 2)
                .fill(Color.white)
                .frame(size.addingConstantValue(kCons))
            Rectangle().frame(CGSize(width: size.width + kCons, height: kCons))

            Circle()
                .stroke(Color.black, lineWidth: kCons/2)
                .fill(Color.blue)
                .frame(size.addingConstantValue(-size.width * self.kInnerMultipler * 2))
            
            Circle()
                .fill(Color.white)
                .stroke(Color.black, lineWidth: kCons)
                .frame(size.addingConstantValue(-size.width * self.kInnerMultipler))
            
            Circle()
                .fill(Color.white)
                .stroke(Color.black, lineWidth: kCons/2)
                .frame((size.addingConstantValue(-size.width * self.kInnerMultipler * 1.2)))
            if isError {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundStyle(Color.red)
            }
        }.background(.clear)
    }
}

//struct PokeballView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokeballView()
//    }
//}
//
