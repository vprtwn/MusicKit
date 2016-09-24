//  Copyright (c) 2015 Ben Guo. All rights reserved.

@import Foundation;
@import CoreMIDI;

typedef NS_ENUM(unsigned char, MKMIDIMessage) {
    // [note #, velocity]
    MKMIDIMessageNoteOff = 0x80,
    // [note #, velocity]
    MKMIDIMessageNoteOn = 0x90,
    // [note #, pressure]
    MKMIDIMessageAftertouch = 0xA0,
    // [controller #, value]
    MKMIDIMessageController = 0xB0,
    // [program #]
    MKMIDIMessageProgramChange = 0xC0,
    // [pressure]
    MKMIDIMessageChannelPressure = 0xD0,
    // [position, position] (two bytes should be combined)
    MKMIDIMessagePitchWheel = 0xE0,
};

/// redefinition of MIDINotificationMessageID for Swift interop
typedef NS_ENUM(NSUInteger, MKMIDINotification) {
    MKMIDINotificationSetupChanged              = 1,
    MKMIDINotificationObjectAdded				= 2,
    MKMIDINotificationObjectRemoved			    = 3,
    MKMIDINotificationPropertyChanged			= 4,
    MKMIDINotificationThruConnectionsChanged	= 5,
    MKMIDINotificationSerialPortOwnerChanged	= 6,
    MKMIDINotificationIOError					= 7
};

/** 
 A callback receiving an array of MIDI packets of the form:
 [channel #, message type, data,...]
 */
typedef void (^MKMIDIReadCallback)(NSArray * _Nullable packets);
typedef void (^MKMIDINotifyCallback)(MKMIDINotification messageID);

@interface MKMIDIProc: NSObject

+ (void (* _Null_unspecified)(const MIDIPacketList * _Nonnull pktlist, void * _Nullable procRef, void * _Nullable srcRef))readProc;
+ (void)setReadCallback:(MKMIDIReadCallback _Nullable )callback;

+ (void (* _Null_unspecified)(const MIDINotification * _Nonnull notification, void * _Nullable refCon))notifyProc;
+ (void)setNotifyCallback:(MKMIDINotifyCallback _Nullable)callback;

@end
