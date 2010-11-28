//
//  RuleEditorPanelController.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RuleEditorPanelController.h"


@implementation RuleEditorPanelController

@synthesize hostName;
@synthesize networkSpeed;
@synthesize networkLatency;
@synthesize networkPacketLoss;
@synthesize hostProgressIndicator;
@synthesize networkDelaySlider;

- (id)init {
  self = [super initWithWindowNibName:@"RuleEditor"];
  return self;
}

- (void)windowDidLoad {
  [self.hostProgressIndicator startAnimation:self];
}


- (void)saveAction:(id)sender {
  NSLog(@"SAVE ACTION BRO");
  [[self window] performClose:sender];
}

- (void)dealloc {
  [hostName release];
  [networkSpeed release];
  [networkLatency release];
  [networkPacketLoss release];
  [hostProgressIndicator release];
  [networkDelaySlider release];
  [super dealloc];
}
@end
