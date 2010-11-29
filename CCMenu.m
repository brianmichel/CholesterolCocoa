//
//  CCMenu.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CCMenu.h"


@implementation CCMenu
@synthesize statusWindowController;

- (void)awakeFromNib {
  statusWindowController = [[StatusWindowController alloc] init];
}

- (void)showStatusWindow:(id)sender {
  NSWindow *window = [statusWindowController window];
  [window makeKeyAndOrderFront:NSApp];
}

- (void)launchPreferences:(id)sender {
  NSString *userName = NSUserName();
  NSFileManager *fm = [NSFileManager defaultManager];
  if ([fm fileExistsAtPath:[NSString stringWithFormat:@"/Users/%@/Library/PreferencePanes/Cholesterol Preference Pane.prefPane/", userName]]) {
    [[NSWorkspace sharedWorkspace] openFile:[NSString stringWithFormat:@"/Users/%@/Library/PreferencePanes/Cholesterol Preference Pane.prefPane/", userName]];
  } else {
    NSString *current = [fm currentDirectoryPath];
  }
}

- (void)dealloc {
  [statusWindowController release];
  [super dealloc];
}

@end