//
//  UIImage+resizedImage.swift
//  LastFM
//
//  Created by Vadim Koronchik on 2/2/19.
//  Copyright © 2019 Vadim Koronchik. All rights reserved.
//

import Cocoa

extension NSImage {
    
    func resizeTo(_ newSize: CGSize) -> NSImage {
        let ratioX = newSize.width / size.width
        let ratioY = newSize.height / size.height
        let ratio = ratioX < ratioY ? ratioX : ratioY
        let newHeight = size.height * ratio
        let newWidth = size.width * ratio
        let canvasSize = CGSize(width: newSize.width,
                                height: CGFloat(ceil(newSize.width / size.width * size.height)))
        let img = NSImage(size: canvasSize)
        img.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        draw(in: NSRect(origin: CGPoint(x: (canvasSize.width - (size.width * ratio)) / 2, y: (canvasSize.height - (size.height * ratio)) / 2), size: NSSize(width: newWidth,height: newHeight)), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        img.unlockFocus()
        
        return img
    }

}
