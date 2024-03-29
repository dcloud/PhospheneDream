//
//  ImageFilters.swift
//  PhospheneDream
//
//  Created by Daniel Cloud on 10/30/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Foundation
import AppKit

typealias Filter = CIImage -> CIImage

typealias Parameters = Dictionary<String, AnyObject>

extension CIFilter {
    convenience init(name: String, parameters: Parameters) {
        self.init(name: name)
        setDefaults()
        for (key, value: AnyObject) in parameters {
            setValue(value, forKey: key)
        }
    }

    var outputImage: CIImage {
        return self.valueForKey(kCIOutputImageKey) as CIImage
    }
}

func blur(radius: Double) -> Filter {
    return { image in
        let parameters: Parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        let filter = CIFilter(name: "CIGaussianBlur",
            parameters: parameters)

        return filter.outputImage
    }
}

func colorGenerator(color: NSColor) -> Filter {
    return { _ in
        let parameters: Parameters = [kCIInputColorKey: color]
        let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters)
        return filter.outputImage
    }
}

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters: Parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters)
        let cropRect = image.extent()

        return filter.outputImage.imageByCroppingToRect(cropRect)
    }
}

func colorOverlay(color: NSColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
    }
}
