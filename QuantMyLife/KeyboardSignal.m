#import <Carbon/Carbon.h>
#import "KeyboardSignal.h"


@implementation KeyboardSignal

- (void)keyDown:(NSEvent *)theEvent {
    NSMutableData *data = [NSMutableData data];
    
    [self logEvent:data];
}

- (id)init
{
    self = [super initWithSlug:@"keyboard" formatVersion:1];

    // Generate event for every key-down event (includes other apps)
    // You need to have 'Enable Access for Assistive Devices' checked in your System Prefs.
    // N.B. key value not reported by event
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyUpMask)
                                           handler:^(NSEvent *incomingEvent) {
                                               [self keyDown:incomingEvent];
                                           }];
    

    return self;
}

- (void)dealloc
{
    [super dealloc];
}


@end
