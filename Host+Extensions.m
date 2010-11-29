//
//  Host+Extensions.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Host+Extensions.h"
#import "Hosts.h"

@implementation Host(Extensions)

- (NSArray *)hosts {
  NSError *err = nil;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Host" inManagedObjectContext:cc_ctx()];
  [fetchRequest setEntity:entity];
  NSArray *items = [cc_ctx() executeFetchRequest:fetchRequest error:&err];
  [fetchRequest release];
  return items;
}

@end
