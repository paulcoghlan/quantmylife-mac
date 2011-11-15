//
//  SamplerPanel.m
//  Mojomatic
//
//  Created by Paul Coghlan on 11/11/2011.
//  Copyright 2011 G10K Ltd. All rights reserved.
//

#import "MojoSamplerPanel.h"

@implementation MojoSamplerPanel

@synthesize panel;
@synthesize samplerSignal;
@synthesize slider;

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)okAction:(id)sender {
    [self.samplerSignal updateSample];
    [self.samplerSignal startTimer];
    [self close];
}

- (IBAction)abortAction:(id)sender {
    [samplerSignal startTimer];
    [self close];
}

- (IBAction)takeFloatValueForMojoFrom:(id)sender {
    mojoValue = [sender floatValue]; 
    [samplerSignal setMojoValue:mojoValue];
}



@end
