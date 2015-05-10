#import "MIDIProc.h"

static MIDIReadProcCallback _readProc = nil;
static MIDINotifyProcCallback _notifyProc = nil;

/**
 Currently only supports Voice commands.
 http://www.gweep.net/~prefect/eng/reference/protocol/midispec.html
 */
static void readProc(const MIDIPacketList *packetList, void *procRef, void *srcRef) {
    if (_readProc) {
        NSUInteger packetCount = packetList->numPackets;
        NSMutableArray *packets = [NSMutableArray array];
        const MIDIPacket *packet = &packetList->packet[0];
        UInt16 nBytes;
        for (int i=0; i<packetCount; i++) {
            nBytes = packet->length;
            UInt16 iByte, size;
            iByte = 0;
            while (iByte < nBytes) {
                size = 0;

                // parse status byte
                unsigned char status = packet->data[iByte];
                unsigned char messageType = status & 0xF0;
                unsigned char messageChannel = status & 0xF;
                if (status == MIDIMessageProgramChange ||
                    status == MIDIMessageChannelPressure) {
                    size = 2;
                }
                else if (status == MIDIMessageNoteOff ||
                         status == MIDIMessageNoteOn ||
                         status == MIDIMessageAftertouch ||
                         status == MIDIMessageController ||
                         status == MIDIMessagePitchWheel) {
                    size = 3;
                }
                else {
                    size = 1;
                }

                switch (messageType) {
                    case MIDIMessageNoteOff:
                    case MIDIMessageNoteOn:
                    case MIDIMessageAftertouch:
                    case MIDIMessageController:
                    case MIDIMessagePitchWheel:
                    {
                        NSNumber *byte1 = @(packet->data[iByte + 1]);
                        NSNumber *byte2 = @(packet->data[iByte + 2]);
                        NSArray *p = @[@(messageChannel), @(messageType), byte1, byte2];
                        [packets addObject:p];
                        break;
                    }
                    case MIDIMessageProgramChange:
                    case MIDIMessageChannelPressure:
                    {
                        NSNumber *byte1 = @(packet->data[iByte + 1]);
                        NSArray *p = @[@(messageChannel), @(messageType), byte1];
                        [packets addObject:p];
                        break;
                    }
                    default:
                        break;
                }

                iByte += size;
            }
            packet = MIDIPacketNext(packet);
        }
        _readProc(packets);
    }
}

static void notifyProc(const MIDINotification *notification, void *refCon) {
    if (_notifyProc) {
        _notifyProc(notification);
    }
}

@implementation MIDIProc

+ (void (*)(const MIDIPacketList *pktlist, void *readProcRefCon, void *srcConnRefCon))readProc
{
    return readProc;
}

+ (void)setReadProc:(MIDIReadProcCallback)callback
{
    _readProc = callback;
}

+ (void (*)(const MIDINotification *notification, void *refCon))notifyProc
{
    return notifyProc;
}

+ (void)setNotifyProc:(MIDINotifyProcCallback)callback
{
    _notifyProc = callback;
}

@end
