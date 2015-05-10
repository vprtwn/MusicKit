//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

protocol MIDIMessage {
    var channel : UInt { get }
}

public struct MIDINoteMessage : MIDIMessage {
    /// Note on: true, Note off: false
    let on : Bool
    let channel : UInt
    let noteNumber : UInt
    let velocity : UInt
}
