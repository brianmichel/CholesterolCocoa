//
//  RuleEditorPanelController.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RuleEditorPanelController : NSWindowController {
  IBOutlet NSTextField *hostName;
  IBOutlet NSComboBox *networkSpeed;
  IBOutlet NSTextField *networkLatency;
  IBOutlet NSSlider *networkPacketLoss;
  IBOutlet NSProgressIndicator *hostProgressIndicator;
  IBOutlet NSSlider *networkDelaySlider;
}

@property (nonatomic, retain) NSTextField *hostName;
@property (nonatomic, retain) NSComboBox *networkSpeed;
@property (nonatomic, retain) NSTextField *networkLatency;
@property (nonatomic, retain) NSSlider *networkPacketLoss;
@property (nonatomic, retain) NSProgressIndicator *hostProgressIndicator;
@property (nonatomic, retain) NSSlider *networkDelaySlider;

- (void)saveAction:(id)sender;

@end
