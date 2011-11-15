#import <Carbon/Carbon.h>
#import "KeyboardSignal.h"


@implementation KeyboardSignal

- (id)init
{
    // TODO: overloading initWithSlug to not take sample
    self = [super initWithSlug:@"keyboard" formatVersion:1 sampleMs:0];
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyUpMask)
                                           handler:^(NSEvent *incomingEvent) {
                                               [self keyDown:incomingEvent];
                                           }];
    

    return self;
}

- (void)keyDown:(NSEvent *)theEvent {
    NSMutableData *data = [NSMutableData data];
    
    [self logEvent:data];
}

- (void)dealloc
{
    [super dealloc];
}


@end
