//
//  HomeViewModel.swift
//  MetalQueen
//
//  Created by Condy on 2021/8/7.
//

import Foundation
import UIKit
import ATMetalBand

typealias maxminTuple = (current: Float, min: Float, max: Float)?
typealias FilterCallback = (_ value: Float) -> C7FilterProtocol
typealias FilterResult = (filter: C7FilterProtocol, maxminValue: maxminTuple, callback: FilterCallback?)

enum ViewControllerType: String {
    case Luminance = "亮度"
    case Opacity = "透明度"
    case Hue = "色相角度"
    case Exposure = "曝光"
    case Contrast = "对比度"
    case Saturation = "饱和度"
    case ChannelRGBA = "RGBA通道"
    case HighlightShadow = "高光阴影"
    case Monochrome = "黑白照片"
    case ChromaKey = "类似绿幕抠图"
    case ChromaKey2 = "扣掉红色"
    case ReplaceColor = "替换背景颜色"
    case Haze = "变模糊"
    case ZoomBlur = "中心点缩放模糊"
    case Pixellated = "马赛克像素化"
    case abao = "阿宝色滤镜"
    case ColorInvert = "颜色反转"
    case Color2Gray = "灰度图滤镜"
    case Color2BGRA = "颜色转BGRA"
    case Color2BRGA = "颜色转BRGA"
    case Color2GBRA = "颜色转GBRA"
    case Color2GRBA = "颜色转GRBA"
    case Color2RBGA = "颜色转RBGA"
    case Bulge = "鼓起效果"
    case HueBlend = "色相融合"
    case AlphaBlend = "透明度融合"
    case LuminosityBlend = "亮度融合"
    case Crop = "图形延展补齐"
    case Rotate = "图形旋转"
    case Flip = "图形翻转"
}

extension ViewControllerType {
    var image: UIImage {
        switch self {
        case .ColorInvert:
            return UIImage.init(named: "yuan000")!
        case .Color2BGRA, .Color2BRGA, .Color2GBRA, .Color2GRBA, .Color2RBGA:
            return UIImage.init(named: "IMG_1668")!
        case .Color2Gray:
            return UIImage.init(named: "yuan002")!
        case .ZoomBlur, .Crop:
            return UIImage.init(named: "IMG_1668")!
        case .ChromaKey:
            return UIImage.init(named: "lvmu")!
        case .ChromaKey2, .ReplaceColor:
            return UIImage.init(named: "IMG_2606")!
        default:
            return UIImage.init(named: "timg-3")!
        }
    }
    
    func setupFilterObject() -> FilterResult {
        switch self {
        case .Luminance:
            var filter = C7Luminance()
            return (filter, (filter.luminance, filter.minLuminance, filter.maxLuminance), {
                filter.luminance = $0
                return filter
            })
        case .ColorInvert:
            let filter = C7ComputeFilter(with: .colorInvert)
            return (filter, nil, nil)
        case .Color2BGRA:
            let filter = C7ComputeFilter(with: .color2BGRA)
            return (filter, nil, nil)
        case .Color2BRGA:
            let filter = C7ComputeFilter(with: .color2BRGA)
            return (filter, nil, nil)
        case .Color2GBRA:
            let filter = C7ComputeFilter(with: .color2GBRA)
            return (filter, nil, nil)
        case .Color2GRBA:
            let filter = C7ComputeFilter(with: .color2GRBA)
            return (filter, nil, nil)
        case .Color2RBGA:
            let filter = C7ComputeFilter(with: .color2RBGA)
            return (filter, nil, nil)
        case .Opacity:
            var filter = C7Opacity()
            return (filter, (filter.opacity, filter.minOpacity, filter.maxOpacity), {
                filter.opacity = $0
                return filter
            })
        case .Exposure:
            var filter = C7Exposure()
            return (filter, (filter.exposure, -2, 2), {
                filter.exposure = $0
                return filter
            })
        case .abao:
            var filter = C7LookupFilter(image: C7Image(named: "lut_abao")!)
            filter.intensity = -0.5
            return (filter, (filter.intensity, -2, 2), {
                filter.intensity = $0
                return filter
            })
        case .ZoomBlur:
            var filter = C7ZoomBlur()
            return (filter, (filter.blurSize, 0, 20), {
                filter.blurSize = $0
                return filter
            })
        case .Pixellated:
            var filter = C7Pixellated()
            return (filter, (filter.pixelWidth, 0, 0.2), {
                filter.pixelWidth = $0
                return filter
            })
        case .HueBlend:
            let filter = C7BlendFilter(with: .hue, image: C7Image(named: "yuan000")!)
            return (filter, nil, nil)
        case .AlphaBlend:
            var filter = C7BlendFilter(with: .alpha(mixturePercent: 0.5), image: C7Image(named: "yuan000")!)
            return (filter, (0.5, 0, 1), {
                filter.updateBlend(.alpha(mixturePercent: $0))
                return filter
            })
        case .LuminosityBlend:
            let filter = C7BlendFilter(with: .luminosity, image: C7Image(named: "yuan000")!)
            return (filter, nil, nil)
        case .Hue:
            var filter = C7Hue()
            return (filter, (filter.hue, 0, 45), {
                filter.hue = $0
                return filter
            })
        case .Bulge:
            var filter = C7Bulge()
            return (filter, (filter.scale, -1, 1), {
                filter.scale = $0
                return filter
            })
        case .Color2Gray:
            let filter = C7ComputeFilter(with: .color2Gray)
            return (filter, nil, nil)
        case .Contrast:
            var filter = C7Contrast()
            return (filter, (filter.contrast, 0, 4), {
                filter.contrast = $0
                return filter
            })
        case .Saturation:
            var filter = C7Saturation()
            return (filter, (filter.saturation, 0, 2), {
                filter.saturation = $0
                return filter
            })
        case .ChannelRGBA:
            var filter = C7ChannelRGBA()
            filter.color = UIColor.cyan
            return (filter, (filter.red, 0, 10), {
                filter.red = $0
                return filter
            })
        case .HighlightShadow:
            var filter = C7HighlightShadow()
            filter.highlights = 0.5
            filter.shadows = 0.5
            return (filter, (0.5, 0, 1), {
                filter.highlights = $0
                filter.shadows = $0
                return filter
            })
        case .Monochrome:
            var filter = C7Monochrome()
            filter.intensity = 0.5
            filter.color = UIColor.red
            return (filter, (0.5, 0, 1), {
                filter.intensity = $0
                return filter
            })
        case .ChromaKey:
            var filter = C7ChromaKey()
            filter.smoothing = 0.25
            filter.color = UIColor.green
            return (filter, (0.25, 0, 1), {
                filter.smoothing = $0
                return filter
            })
        case .ChromaKey2:
            var filter = C7ChromaKey()
            filter.smoothing = 0.05
            filter.color = UIColor.red
            return (filter, (0.05, 0, 1), {
                filter.smoothing = $0
                return filter
            })
        case .ReplaceColor:
            var filter = C7ReplaceRGBA()
            filter.smoothing = 0.02
            filter.chroma = UIColor.red
            filter.replaceColor = UIColor.purple
            return (filter, (0.02, 0, 1), {
                filter.smoothing = $0
                return filter
            })
        case .Haze:
            var filter = C7Haze()
            filter.distance = 0.5
            filter.slope = 0.5
            return (filter, (0.5, -1, 1), {
                filter.distance = $0
                filter.slope = $0
                return filter
            })
        case .Crop:
            var filter = C7Crop()
            filter.origin = CGPoint(x: 0.3, y: 0.3)
            filter.height = 1080
            return (filter, (0.3, 0, 1), {
                filter.origin = CGPoint(x: CGFloat($0), y: CGFloat($0))
                return filter
            })
        case .Rotate:
            var filter = C7Rotate()
            filter.angle = 10
            return (filter, (filter.angle, 0, 360), {
                filter.angle = $0
                return filter
            })
        case .Flip:
            var filter = C7Flip()
            filter.vertical = true
            return (filter, nil, nil)
        }
    }
}

struct HomeViewModel {
    lazy var section: [String] = {
        return ["效果类", "形状变化", "模糊处理", "图片融合类", "滤镜类"]
    }()
    
    lazy var datas: [[ViewControllerType]] = {
        return [shape, effect, blur, blend, filter]
    }()
    
    let effect: [ViewControllerType] = [
        .Opacity, .Exposure, .Luminance,
        .Hue, .Bulge, .Contrast,
        .Saturation, .ChannelRGBA, .HighlightShadow,
        .Monochrome, .ChromaKey, .ChromaKey2,
        .ReplaceColor, .Haze,
    ]
    
    let shape: [ViewControllerType] = [
        .Crop, .Rotate, .Flip,
    ]
    
    let blur: [ViewControllerType] = [
        .ZoomBlur, .Pixellated,
    ]
    
    let blend: [ViewControllerType] = [
        .HueBlend, .AlphaBlend, .LuminosityBlend,
    ]
    
    let filter: [ViewControllerType] = [
        .abao, .ColorInvert,
        .Color2BGRA, .Color2BRGA, .Color2GBRA,
        .Color2GRBA, .Color2RBGA,
    ]
}
