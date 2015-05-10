#import <Foundation/Foundation.h>
@import CoreMIDI;

typedef NS_ENUM(unsigned char, MIDIMessage) {
    // [note #, velocity]
    MIDIMessageNoteOff = 0x80,
    // [note #, velocity]
    MIDIMessageNoteOn = 0x90,
    // [note #, pressure]
    MIDIMessageAftertouch = 0xA0,
    // [controller #, value]
    MIDIMessageController = 0xB0,
    // [program #]
    MIDIMessageProgramChange = 0xC0,
    // [pressure]
    MIDIMessageChannelPressure = 0xD0,
    // [position, position] (two bytes should be combined)
    MIDIMessagePitchWheel = 0xE0,
};

/** 
 A callback receiving an array of MIDI packets of the form:
 [channel #, message type, data,...]
 */
typedef void (^MIDIReadProcCallback)(NSArray *packets);
typedef void (^MIDINotifyProcCallback)(const MIDINotification *notification);

@interface MIDIProc : NSObject

+ (void (*)(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon))readProc;
+ (void)setReadProc:(MIDIReadProcCallback)callback;

+ (void (*)(const MIDINotification *notification, void *refCon))notifyProc;
+ (void)setNotifyProc:(MIDINotifyProcCallback)callback;

@end
