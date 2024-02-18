//
//  PokemonImageView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit
import SVGKitSwift
import SVGKit

public class PokemonImageView: UIImageView {
    
}

extension UIImageView {
    
    func downloadedsvg(from url: URL?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(url.absoluteString)
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
            else { 
                return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
