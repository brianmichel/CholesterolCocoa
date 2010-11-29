//
//  RuleEditorPanelController.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RuleEditorPanelController.h"
#import "Hosts.h"

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
  Host *currentHost;
  //Try to fetch the host for the given name, if it is not nil set currentHost otherwise make a new host then set it.
  if ([[Hosts sharedInstance] fetchHostForName:[self.hostName stringValue]] != nil) {
    currentHost = [[Hosts sharedInstance] fetchHostForName:[self.hostName stringValue]];
  } else {
    [[Hosts sharedInstance] newHostForName:[self.hostName stringValue]];
    currentHost = [[Hosts sharedInstance] fetchHostForName:[self.hostName stringValue]];
  }
  
  [[Hosts sharedInstance] newRuleForHost:currentHost withSpeed:[NSNumber numberWithInt:[self.networkSpeed intValue]] latency:[NSNumber numberWithInt:10] packetLoss:[NSNumber numberWithFloat:0.10] delay:[NSNumber numberWithInt:250]];
  
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
