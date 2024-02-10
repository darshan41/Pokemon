//
//  GifView.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//


import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = Color.fillColor(colorScheme).toUIColor
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct CenteredGifView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        let fillColor = Color.fillColor(colorScheme)
        GeometryReader { geometry in
            VStack {
                Spacer()
                GifImage("pokeball")
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .padding()
                    .background(fillColor)
                Spacer()
            }.background(fillColor)
        }.background(fillColor)
    }
}




//#Preview {
//    GifImage("pokeball")
//}
