#import "Signal.h"
// Use @class to get bi-directional #import working
@class MojoSamplerPanel;

@interface MojoSamplerSignal : Signal {
    
@private
    MojoSamplerPanel *samplerPanel;
    int mojoValue;
}

@property (nonatomic, retain) MojoSamplerPanel *samplerPanel;
@property (nonatomic) int mojoValue;

- (void)timerExpiry:(NSTimer *)timer;
- (void)updateSample;
- (void)startTimer;

@end
