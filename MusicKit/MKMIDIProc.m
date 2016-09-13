//  Copyright (c) 2015 Ben Guo. All rights reserved.

#import "MKMIDIProc.h"

static MKMIDIReadCallback _readCallback = nil;
static MKMIDINotifyCallback _notifyCallback = nil;

/**
 Currently only supports Voice commands.
 http://www.gweep.net/~prefect/eng/reference/protocol/midispec.html
 */
static void readProc(const MIDIPacketList *packetList, void *procRef, void *srcRef) {
    if (!_readCallback) {
        return;
    }
    NSUInteger packetCount = packetList->numPackets;
    NSMutableArray *packets = [NSMutableArray array];
    const MIDIPacket *packet = &packetList->packet[0];
    UInt16 nBytes;
    for (NSUInteger i=0; i<packetCount; i++) {
        nBytes = packet->length;
        UInt16 iByte, size;
        iByte = 0;
        while (iByte < nBytes) {
            unsigned char status = packet->data[iByte];
            unsigned char messageType = status & 0xF0;
            unsigned char messageChannel = status & 0xF;
            switch (messageType) {
                case MKMIDIMessageNoteOff:
                case MKMIDIMessageNoteOn:
                case MKMIDIMessageAftertouch:
                case MKMIDIMessageController:
                case MKMIDIMessagePitchWheel:
                {
                    size = 3;
                    NSNumber *byte1 = @(packet->data[iByte + 1]);
                    NSNumber *byte2 = @(packet->data[iByte + 2]);
                    NSArray *p = @[@(messageChannel), @(messageType), byte1, byte2];
                    [packets addObject:p];
                    break;
                }
                case MKMIDIMessageProgramChange:
                case MKMIDIMessageChannelPressure:
                {
                    size = 2;
                    NSNumber *byte1 = @(packet->data[iByte + 1]);
                    NSArray *p = @[@(messageChannel), @(messageType), byte1];
                    [packets addObject:p];
                    break;
                }
                default:
                {
                    size = 1;
                    break;
                }
            }
            iByte += size;
        }
        packet = MIDIPacketNext(packet);
    }
    _readCallback(packets);
}

static void notifyProc(const MIDINotification *notification, void *refCon) {
    if (!_notifyCallback) {
        return;
    }
    MKMIDINotification messageID = (MKMIDINotification)notification->messageID;
    /// For now, just return the message id.
    /// TODO: parse the object corresponding to the message id.
    _notifyCallback(messageID);
}

@implementation MKMIDIProc

+ (void (*)(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon))readProc
{
    return readProc;
}

+ (void)setReadCallback:(MKMIDIReadCallback)callback
{
    _readCallback = callback;
}

+ (void (*)(const MIDINotification *notification, void *refCon))notifyProc
{
    return notifyProc;
}

+ (void)setNotifyCallback:(MKMIDINotifyCallback)callback
{
    _notifyCallback = callback;
}

@end
