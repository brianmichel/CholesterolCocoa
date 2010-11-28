//
//  CCStatusItem.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CCStatusItem : NSStatusItem {
  NSImage *regularImage;
  NSImage *altImage;
}

@property (nonatomic, retain) NSImage *regularImage;
@property (nonatomic, retain) NSImage *altImage;

- (id)initWithRegImage:(NSString *)reg andAltImage:(NSString *)alt;

@end
