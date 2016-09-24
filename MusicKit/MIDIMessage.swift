//  Copyright (c) 2015 Ben Guo. All rights reserved.

import Foundation

public protocol MIDIMessage {
    /// The message's channel
    var channel: UInt { get }

    /// Returns the MIDI packet data representation of this message
    func data() -> [UInt8]

    /// Returns a copy of this message on the given channel
    func copyOnChannel(_ channel: UInt) -> Self
}

public struct MIDINoteMessage: MIDIMessage {
    /// Note on: true, Note off: false
    public let on: Bool
    public let channel: UInt
    public let noteNumber: UInt
    public let velocity: UInt

    public init(on: Bool, channel: UInt = 0, noteNumber: UInt, velocity: UInt) {
        self.on = on
        self.channel = channel
        self.noteNumber = noteNumber
        self.velocity = velocity
    }

    public func data() -> [UInt8] {
        let messageType = self.on ? MKMIDIMessage.noteOn.rawValue : MKMIDIMessage.noteOff.rawValue
        let status = UInt8(messageType + UInt8(self.channel))
        return [UInt8(status), UInt8(self.noteNumber), UInt8(self.velocity)]
    }

    public func copyOnChannel(_ channel: UInt) -> MIDINoteMessage {
        return MIDINoteMessage(on: on, channel: channel, noteNumber: noteNumber, velocity: velocity)
    }

    /// The message's pitch
    public var pitch: Pitch {
        return Pitch(midi: Float(noteNumber))
    }

    /// Applies the given `Harmonizer` to the message.
    public func harmonize(_ harmonizer: Harmonizer) -> [MIDINoteMessage] {
        let ps = harmonizer(pitch)
        var messages = [MIDINoteMessage]()
        // TODO: add a PitchSet -> Array method so this can be mapped
        for p in ps {
            messages.append(MIDINoteMessage(on: self.on, channel: self.channel,
                noteNumber: UInt(p.midi), velocity: self.velocity))
        }
        return messages
    }
}

extension MIDINoteMessage: CustomStringConvertible {
    public var description: String {
        let onString = on ? "On" : "Off"
        return "\(channel): Note \(onString): \(noteNumber) \(velocity)"
    }
}

extension MIDINoteMessage: Transposable {
    public func transpose(_ semitones: Float) -> MIDINoteMessage {
        return MIDINoteMessage(on: self.on,
            channel: self.channel,
            noteNumber: self.noteNumber + UInt(semitones),
            velocity: self.velocity)
    }
}
