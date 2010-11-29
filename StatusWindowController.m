//
//  StatusWindowController.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StatusWindowController.h"
#import "Hosts.h"

@implementation StatusWindowController

@synthesize rulesTable;
@synthesize rulePanel;
@synthesize ruleEditor;
@synthesize overlayText;

- (id)init {
  self = [super initWithWindowNibName:@"StatusWindow"];
  [self.rulesTable setDelegate:self];
  [self.rulesTable setDataSource:self];
  
  return self;
}

- (void)windowWillLoad {

}

- (void)windowDidLoad {
  if (self) {
    
    NSTrackingAreaOptions trackingOptions = NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp;
    trackingArea = [[NSTrackingArea alloc] initWithRect:[self.rulesTable bounds]
                                                options:trackingOptions
                                                  owner:self userInfo:nil];
    
    [self.rulesTable addTrackingArea:trackingArea];
  }
  
  if (!self.overlayText) {
    self.overlayText = [[NSTextField alloc] initWithFrame:[self.rulesTable frame]];
    [self.rulesTable addSubview:self.overlayText];
    [self.overlayText setAutoresizingMask:(NSViewMinXMargin | NSViewMaxXMargin)];
    [self.overlayText setBezeled:NO];
    [self.overlayText setBackgroundColor:[NSColor grayColor]]; 
    [self.overlayText setAlphaValue:0.6f];
  }
  
  [self.overlayText setHidden:YES];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  //[self toggleOverlayVisible:YES];
  NSLog(@"MOUSE ENTERED!");
}

- (void)toggleOverlayVisible:(BOOL)visible {
 [self.overlayText setHidden:!visible];
}

- (void)mouseExited:(NSEvent *)theEvent {
 // [self toggleOverlayVisible:NO];
  NSLog(@"MOUSE EXITED!");
}

#pragma mark -
#pragma mark Tableview Delegate Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [[[Hosts sharedInstance] hosts] count];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
  return 20.0f;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
  NSArray *hosts = [[Hosts sharedInstance] hosts];
  Host *aHost = [hosts objectAtIndex:rowIndex];
  NSArray *rules = [aHost.Rule allObjects];
  FirewallRule *rule = nil;
  if ([rules count] != 0) {
    rule = [rules objectAtIndex:0];
  }
  
  if ([[aTableColumn identifier] isEqualToString:@"a"]) {
    return aHost.active == [NSNumber numberWithBool:YES] ? @"Yes" : @"No";
  } else if ([[aTableColumn identifier] isEqualToString:@"h"]) {
    return aHost.name;
  } else if ([[aTableColumn identifier] isEqualToString:@"b"] && rule != nil) {
    return rule.networkSpeed;
  } else if ([[aTableColumn identifier] isEqualToString:@"p"] && rule != nil) {
    return rule.packetLossRatio;
  }

  return nil;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
  [self showRuleEditorWithTitle:@"Edit Rule"];
  return YES;
}

#pragma mark -
#pragma mark Methods & Actions

- (void)showRuleEditorWithTitle:(NSString *)title {
  if (self.ruleEditor) {
    [self.ruleEditor release];
    self.ruleEditor = nil;
  }
  self.ruleEditor = [[RuleEditorPanelController alloc] init];
  [[self.ruleEditor window] setTitle:title];
  [[self.ruleEditor window] makeKeyAndOrderFront:NSApp];
}

- (void)addRule:(id)sender {
  [self showRuleEditorWithTitle:@"New Rule"];
  NSLog(@"YUP ADD A RULE");
}

- (void)removeRule:(id)sender {
  NSLog(@"YUP REMOVE A RULE");
}

- (void)dealloc {
  [ruleEditor release];
  [rulesTable release];
  [super dealloc];
}

@end
