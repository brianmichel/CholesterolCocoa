//
//  StatusWindowController.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RuleEditorPanelController.h"


@interface StatusWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate> {
  RuleEditorPanelController *ruleEditor;
  NSTrackingArea *trackingArea;
  IBOutlet NSTableView *rulesTable;
  IBOutlet NSPanel *rulePanel;
  NSTextField *overlayText;
}

@property (nonatomic, retain) RuleEditorPanelController *ruleEditor;
@property (nonatomic, retain) NSTableView *rulesTable;
@property (nonatomic, retain) NSPanel *rulePanel;
@property (nonatomic, retain) NSTextField *overlayText;

- (void)addRule:(id)sender;
- (void)removeRule:(id)sender;
- (void)showRuleEditorWithTitle:(NSString *)title;
- (void)toggleOverlayVisible:(BOOL)visible;

@end
