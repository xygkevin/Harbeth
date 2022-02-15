//
//  C7Crop.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/15.
//

import Foundation

public struct C7Crop: C7FilterProtocol {
    
    /// The adjusted contrast, from 0 to 1.0, with a default of 0.0
    public var origin: CGPoint = .zero
    
    public var width: Int = 0
    public var height: Int = 0
    
    public var modifier: Modifier {
        return .compute(kernel: "C7Crop")
    }
    
    public var factors: [Float] {
        return [Float(origin.x), Float(origin.y)]
    }
    
    public func outputSize(input size: MTQSize) -> MTQSize {
        let w: Int = width > 0 ? width : size.width
        let h: Int = height > 0 ? height : size.height
        return (width: w, height: h)
    }
    
    public init() { }
}
