//
//  DeviceType.swift
//  MusicKit
//
//  Created by Ben Guo on 9/26/15.
//  Copyright © 2015 benzguo. All rights reserved.
//

import UIKit

enum DeviceType {
    case iPhone4
    case iPhone4s
    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPodTouch5
    case iPodTouch6
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPadMini1
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro
    case Unknown

    var ppi: CGFloat? {
        switch self {
        case .iPhone4, .iPhone4s, iPhone5, .iPhone5c, .iPhone5s, .iPhone6,
        .iPhone6s, .iPodTouch5, .iPodTouch6, .iPadMini2, .iPadMini3, .iPadMini4:
            return 326.0
        case iPhone6Plus, .iPhone6sPlus:
            return 401.0
        case .iPad3, .iPad4, .iPadAir, .iPadAir2, .iPadPro:
            return 264.0
        case .iPad2:
            return 132.0
        case .iPadMini1:
            return 163.0
        default:
            return nil
        }
    }
}

extension UIDevice {
    public static var mmPerPixel: CGFloat {
        let mmPerInch: CGFloat = 25.4
        if let ppi = self.deviceType.ppi {
            return (1.0/ppi)*mmPerInch*UIScreen.mainScreen().scale
        }
        else {
            return 0.15785*UIScreen.mainScreen().scale
        }
    }

    static var deviceType: DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)
        var identifier = ""
        for child in mirror.children where child.value as? Int8 != 0 {
            identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
        }

        switch identifier {
        case "iPod5,1":
            return .iPodTouch5
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return .iPhone4
        case "iPhone4,1":
            return .iPhone4s
        case "iPhone5,1", "iPhone5,2":
            return .iPhone5
        case "iPhone5,3", "iPhone5,4":
            return .iPhone5c
        case "iPhone6,1", "iPhone6,2":
            return .iPhone5s
        case "iPhone7,1":
            return .iPhone6
        case "iPhone7,2":
            return .iPhone6Plus
        case "iPhone8,1":
            return .iPhone6s
        case "iPhone8,2":
            return .iPhone6sPlus
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return .iPadAir
        case "iPad5,1", "iPad5,3", "iPad5,4":
            return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":
            return .iPadMini1
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return .iPadMini3
        default:
            return .Unknown
        }
    }
}

