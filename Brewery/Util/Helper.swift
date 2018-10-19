//
//  Helper.swift
//  Brewery
//
//  Created by Alvaro Blazquez on 16/10/18.
//  Copyright © 2018 Alvaro Blazquez. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}

extension String {
    /// - returns: First Character of String, formatted without Accents and the numbers will be #
    var formattedFirstChar: Character {
        let folding = self.folding(options: .diacriticInsensitive, locale: .current).uppercased()
        guard let char = folding.first else {
            return Character("-")
        }
        
        if Int(String(char)) != nil {
            return "#"
        }
        
        return char
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension CALayer {
    
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.2
        self.shadowRadius = 1
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    private func addShadowWithRoundedCorners() {
        let contentLayerName = "layer"
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter { $0.frame.equalTo(self.bounds) }
                .forEach { $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == contentLayerName {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = contentLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}

func += <K, V> (left: inout [K: V], right: [K: V]) {
    for (key, value) in right {
        left[key] = value
    }
}
