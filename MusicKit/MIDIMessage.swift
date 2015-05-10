//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public protocol MIDIMessage {
    var channel : UInt { get }
}

public struct MIDINoteMessage : MIDIMessage {
    /// Note on: true, Note off: false
    public let on : Bool
    public let channel : UInt
    public let noteNumber : UInt
    public let velocity : UInt
}

extension MIDINoteMessage : Printable {
    public var description : String {
        let onOrOff = on ? "On" : "Off"
        return "\(channel): Note \(onOrOff): \(noteNumber) \(velocity)"
    }
}
