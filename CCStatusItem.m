//
//  CCStatusItem.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CCStatusItem.h"


@implementation CCStatusItem

@synthesize regularImage;
@synthesize altImage;

- (id)initWithRegImage:(NSString *)reg andAltImage:(NSString *)alt {
  NSStatusItem *bar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
  self.regularImage = [NSImage imageNamed:reg];
  self.altImage = [NSImage imageNamed:alt];
  
  [bar setHighlightMode:YES];
  [bar setImage:self.regularImage];
  [bar setAlternateImage:self.altImage];
  
  return bar;
}

- (void)dealloc {
  [self.regularImage release];
  [self.altImage release];
  [super dealloc];
}

@end
