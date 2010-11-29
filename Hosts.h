//
//  Hosts.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CholesterolCocoa_AppDelegate.h"
#import "Host.h"
#import "FirewallRule.h"

@interface Hosts : NSObject {
  NSOperationQueue *queue;
}

@property (nonatomic, retain) NSOperationQueue *queue;

+(Hosts *)sharedInstance;
- (void)newHostForName:(NSString *)name;
- (Host *)fetchHostForName:(NSString *)name;
- (NSArray *)fetchRequestWithEntity:(NSString *)entityName andPredicate:(NSPredicate *)predicate;
- (void)newRuleForHost:(Host *)host withSpeed:(NSNumber *)speed latency:(NSNumber *)_latency packetLoss:(NSNumber *)loss delay:(NSNumber *)_delay;
- (NSArray *)hosts;

CholesterolCocoa_AppDelegate *cc_app_delegate();
NSManagedObjectContext *cc_ctx();

@end
