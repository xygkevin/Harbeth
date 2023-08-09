//
//  Error.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/20.
//

import Foundation

public enum CustomError: Swift.Error {
    case unknown
    case error(Swift.Error)
    case image2Texture
    case readFunction(String)
    case commandBuffer
    case computePipelineState(String)
    case renderPipelineState(String, String)
    case source2Texture
    case texture2Image
    case texture2CGImage
    case texture2CIImage
    case CVPixelBufferToCMSampleBuffer
    case outputCIImage(String)
    case cubeResource
    case createCIFilter(String)
    case createRenderMTLTexture
    case makeComputeCommandEncoder
}

extension CustomError: CustomStringConvertible {
    
    /// For each error type return the appropriate description.
    public var description: String {
        localizedDescription
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var localizedDescription: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .image2Texture:
            return "Input image transform texture failed."
        case .readFunction(let name):
            return "Read MTL Function failed with \(name)."
        case .commandBuffer:
            return "Make command buffer failed."
        case .computePipelineState(let name):
            return "Make compute pipeline state failed with \(name)."
        case .renderPipelineState(let vertex, let fragment):
            return "Make rendering pipeline state failed with \(vertex) and \(fragment)."
        case .source2Texture:
            return "Transform to texture failed."
        case .texture2Image:
            return "MTLTexture transform to image failed."
        case .texture2CGImage:
            return "MTLTexture transform to CGImage failed."
        case .texture2CIImage:
            return "MTLTexture transform to CIImage failed."
        case .CVPixelBufferToCMSampleBuffer:
            return "CVPixelBuffer transform to CMSampleBuffer failed."
        case .outputCIImage(let name):
            return "CoreImage \(name) filter bring into being output image failed."
        case .cubeResource:
            return "Read the contents of the cube file failed."
        case .createCIFilter(let name):
            return "Create the filter \(name) is failed."
        case .createRenderMTLTexture:
            return "Create render metel texture is failed."
        case .makeComputeCommandEncoder:
            return "Create a compute command encoder to encode into this command buffer failed."
        default:
            return "Unknown error occurred."
        }
    }
}

extension CustomError {
    static func toCustomError(_ error: Error) -> CustomError {
        if let error = error as? CustomError {
            return error
        } else {
            return .error(error)
        }
    }
}
