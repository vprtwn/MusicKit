//  Copyright (c) 2015 Ben Guo. All rights reserved.

#import <Foundation/Foundation.h>
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
typedef void (^MKMIDIReadCallback)(NSArray *packets);
typedef void (^MKMIDINotifyCallback)(MKMIDINotification messageID);

@interface MKMIDIProc: NSObject

+ (void (*)(const MIDIPacketList *pktlist, void *procRef, void *srcRef))readProc;
+ (void)setReadCallback:(MKMIDIReadCallback)callback;

+ (void (*)(const MIDINotification *notification, void *refCon))notifyProc;
+ (void)setNotifyCallback:(MKMIDINotifyCallback)callback;

@end
