//
//  StatusWindowController.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StatusWindowController.h"


@implementation StatusWindowController

@synthesize rulesTable;
@synthesize rulePanel;
@synthesize ruleEditor;

- (id)init {
  self = [super initWithWindowNibName:@"StatusWindow"];
  [self.rulesTable setDelegate:self];
  [self.rulesTable setDataSource:self];
  return self;
}

- (void)windowWillLoad {
  
}

- (void)windowDidLoad {
  
}

#pragma mark -
#pragma mark Tableview Delegate Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return 5;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
  return 20.0f;
}


- (void)dealloc {
  [ruleEditor release];
  [rulesTable release];
  [super dealloc];
}

- (void)addRule:(id)sender {
  self.ruleEditor = [[RuleEditorPanelController alloc] init];
  [[self.ruleEditor window] setTitle:@"New Rule"];
  [[self.ruleEditor window] makeKeyAndOrderFront:NSApp];
  NSLog(@"YUP ADD A RULE");
}

- (void)removeRule:(id)sender {
  NSLog(@"YUP REMOVE A RULE");
}

@end
