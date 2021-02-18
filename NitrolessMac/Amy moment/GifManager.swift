//
//  GifManager.swift
//  NitrolessiOS
//
//  Created by A W on 16/02/2021.
//

import SwiftUI
import AppKit

class GifManager {
 
    public class func generateGif(_ data: Data) -> AmyGif? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        guard let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) else { return nil }
        guard let delayTime = ((metadata as NSDictionary)["{GIF}"] as? NSMutableDictionary)?["DelayTime"] as? Double else { return nil }
        var images = [NSImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(NSImage(cgImage: image, size: NSZeroSize))
            }
        }
        let calculatedDuration = Double(imageCount) * delayTime
        return AmyGif(image: images, duration: calculatedDuration)
    }
    
}

class AmyGif: NSImage {
    var calculatedDuration: Double!
    var image: [NSImage]!
    
    convenience init(image: [NSImage], duration: Double) {
        self.init()
        self.image = image
        self.calculatedDuration = duration
    }
}
