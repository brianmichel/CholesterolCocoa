//
//  CCMenu.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StatusWindowController.h"

@interface CCMenu : NSMenu {
  StatusWindowController *statusWindowController;
}

@property (nonatomic, retain) StatusWindowController *statusWindowController;

- (void)showStatusWindow:(id)sender;
- (void)launchPreferences:(id)sender;
@end
