#include <stdlib.h>

#import "MojoSamplerSignal.h"

// Need import to prevent @interface warning
#import "MojoSamplerPanel.h"

// Wakeup random msec period - max 1hr
#define MAX_SAMPLE_INTERVAL_MS    (10*1000)

// Default to mid-point on slider
#define DEFAULT_MOJO_VALUE        5

@implementation MojoSamplerSignal

@synthesize samplerPanel;
@synthesize mojoValue;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    [self startTimer];
 
    // TODO: overloading initWithSlug to not take sample
    self = [super initWithSlug:@"mojo-sampler" formatVersion:1 sampleMs:0];

    return self;
}

- (void)timerExpiry:(NSTimer *)timer
{
    // Reset mojoValue
    self.mojoValue = DEFAULT_MOJO_VALUE;
    
    // Create panel & show window
    if (self.samplerPanel == nil) {
        self.samplerPanel = [[MojoSamplerPanel alloc] initWithWindowNibName:@"MojoSamplerPanel"];
        [self.samplerPanel setSamplerSignal:self];
    }
    [samplerPanel showWindow:(nil)];
    [samplerPanel.slider setFloatValue:self.mojoValue];
    [samplerPanel.panel setFloatingPanel:YES];
}

- (void)updateSample
{
    NSMutableData *data = [NSMutableData data];
    [data appendData:[UtilVarints encodeUnsignedFromNumber:[NSNumber numberWithInt:self.mojoValue]]];
    
    [self logEvent:data];
}

- (void)startTimer
{
    float sampleInterval = (random()*MAX_SAMPLE_INTERVAL_MS)/RAND_MAX;
    
    [NSTimer
     scheduledTimerWithTimeInterval:(sampleInterval / 1000.0)
     target:self
     selector:@selector(timerExpiry:)
     userInfo:nil
     repeats:NO];
}


- (void)dealloc
{
    [samplerPanel release];
    [super dealloc];
}

@end
