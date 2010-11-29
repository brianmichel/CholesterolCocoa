//
//  Hosts.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Hosts.h"

@implementation Hosts

static Hosts *sharedInstance = nil;

+(Hosts *)sharedInstance {
  @synchronized(self) {
    if (nil == sharedInstance) {
      sharedInstance = [[Hosts alloc] init];
    }
  }
  return sharedInstance;
}

- (id)init {
  if (!(self = [super init])) {
    return nil;
  }
  return self;
}

- (void)newHostForName:(NSString *)name {
  Host *host = (Host *)[NSEntityDescription insertNewObjectForEntityForName:@"Host" inManagedObjectContext:cc_ctx()];
  host.name = name;
  host.active = [NSNumber numberWithBool:YES];
  
  [cc_app_delegate() saveAction:self];
}

- (void)newRuleForHost:(Host *)host withSpeed:(NSNumber *)speed latency:(NSNumber *)_latency packetLoss:(NSNumber *)loss delay:(NSNumber *)_delay {
  FirewallRule *rule = (FirewallRule *)[NSEntityDescription insertNewObjectForEntityForName:@"FirewallRule" inManagedObjectContext:cc_ctx()];
  rule.host = host;
  rule.pipeNumber;
  rule.connectionLatency = _latency;
  rule.networkSpeed = speed;
  rule.packetLossRatio = loss;
  rule.endpoint = host.name;
  
  [cc_app_delegate() saveAction:self];
}

#pragma mark -
#pragma mark Fetch Requests & Predicates

- (NSArray *)hosts {
  return [self fetchRequestWithEntity:@"Host" andPredicate:nil];
}

- (Host *)fetchHostForName:(NSString *)name {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
  NSArray *results = [self fetchRequestWithEntity:@"FirewallRule" andPredicate:predicate];
  return results && [results count] > 0 ? (Host *)[results objectAtIndex:0] : nil;
}

- (NSArray *)fetchRequestWithEntity:(NSString *)entityName andPredicate:(NSPredicate *)predicate {
  NSError *err = nil;
  
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:cc_ctx()];
  [fetchRequest setEntity:entity];
  
  if (nil != predicate) {
    [fetchRequest setPredicate:predicate];
  }
  
  NSArray *results = [cc_ctx() executeFetchRequest:fetchRequest error:&err];
  
  if (err) {
    return nil;
  }
  
  return results;
}

#pragma mark -
#pragma mark Helper Functions

CholesterolCocoa_AppDelegate *cc_app_delegate() {
  return [[NSApplication sharedApplication] delegate];
}

NSManagedObjectContext *cc_ctx() {
  CholesterolCocoa_AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
  return [delegate managedObjectContext];
}
@end
