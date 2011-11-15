//
//  SamplerPanel.h
//  Mojomatic
//
//  Created by Paul Coghlan on 11/11/2011.
//  Copyright 2011 G10K Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MojoSamplerSignal.h"

@interface MojoSamplerPanel : NSWindowController {
    @private
    MojoSamplerSignal *samplerSignal;
    NSPanel *panel;
    NSSlider *slider;
    int mojoValue;
}

@property (nonatomic, retain) MojoSamplerSignal *samplerSignal;
@property (assign) IBOutlet NSSlider *slider;
@property (assign) IBOutlet NSPanel *panel;

- (IBAction)takeFloatValueForMojoFrom:(id)sender;
- (IBAction)okAction:(id)sender;
- (IBAction)abortAction:(id)sender;


@end
