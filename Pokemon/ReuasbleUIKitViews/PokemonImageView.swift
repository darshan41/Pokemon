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
    
    private var defaultImage: UIImage?
    
}

extension PokemonImageView {
    
    func loadFrom(from url: URL?,onError: (() -> Void)? = nil) {
        guard let url else {
            self.image = defaultImage
            return
        }
        switch ExtendedPokemonSprite.ImageFormat(anyVal: url.pathExtension) {
        case .png:
            self.sd_internalSetImage(with: url, placeholderImage: self.defaultImage, context: [:], setImageBlock: nil, progress: nil)
        case .svg:
            downloadedsvg(from: url,onError: onError)
        default:
            self.image = defaultImage
        }
    }
}

extension UIImageView {
    
    func downloadedsvg(
        from url: URL?,
        contentMode mode: UIView.ContentMode = .scaleAspectFit,
        onError: (() -> Void)? = nil
    ) {
        contentMode = mode
        guard let url else {
            onError?()
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(url.absoluteString)
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
            else {
                onError?()
                return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}

