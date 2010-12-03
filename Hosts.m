//
//  Hosts.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Hosts.h"
#import "FirewallTask.h"


const NSString * kRulesChanged = @"kRulesChanged";

@implementation Hosts

@synthesize queue;
@synthesize currentFirewallTask;

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
  self.queue = [[NSOperationQueue alloc] init];
  return self;
}

- (void)dealloc {
  [currentFirewallTask release];
  [queue release];
  [super dealloc];
}

- (void)newHostForName:(NSString *)name {
  Host *host = (Host *)[NSEntityDescription insertNewObjectForEntityForName:@"Host" inManagedObjectContext:cc_ctx()];
  host.name = name;
  host.active = [NSNumber numberWithBool:YES];
  
  [cc_app_delegate() saveAction:self];
}

- (void)newRuleForHost:(Host *)host withSpeed:(NSNumber *)speed latency:(NSNumber *)_latency packetLoss:(NSNumber *)loss delay:(NSNumber *)_delay {
  self.currentFirewallTask = [[FirewallTask alloc] initWithEndpoint:host.name speed:speed packetloss:loss latency:_delay namedHost:host namedStyle:FirewallTaskCreate];
  [self.currentFirewallTask addObserver:self forKeyPath:@"isFinished" options:0 context:NULL];
  [self.queue addOperation:self.currentFirewallTask];
}

- (void)flushHosts {
  NSArray *hosts = [self fetchRequestWithEntity:@"Host" andPredicate:nil];
  for (Host *host in hosts) {
    [cc_ctx() deleteObject:host];
  }
  self.currentFirewallTask = [[FirewallTask alloc] initWithEndpoint:nil speed:nil packetloss:nil latency:nil namedHost:nil namedStyle:FirewallTaskFlush];
  [self.currentFirewallTask addObserver:self forKeyPath:@"isFinished" options:0 context:NULL];
  [self.queue addOperation:self.currentFirewallTask];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kRulesChanged" object:nil];
  [cc_app_delegate() saveAction:self];
}

#pragma mark -
#pragma mark Fetch Requests & Predicates

- (NSArray *)hosts {
  return [self fetchRequestWithEntity:@"Host" andPredicate:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  FirewallTask *task = (FirewallTask *)object;
  if (task.success && task.style == FirewallTaskCreate) {
    FirewallRule *rule = (FirewallRule *)[NSEntityDescription insertNewObjectForEntityForName:@"FirewallRule" inManagedObjectContext:cc_ctx()];
    rule.host = task.host;
    rule.pipeNumber;
    rule.connectionLatency = task.latency;
    rule.networkSpeed = task.speed;
    rule.packetLossRatio = task.loss;
    rule.endpoint = task.host.name;

    [cc_app_delegate() saveAction:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kRulesChanged" object:nil];
  }

  [task removeObserver:self forKeyPath:@"isFinished"];
  self.currentFirewallTask = nil;
  [self.currentFirewallTask release];
}

- (Host *)fetchHostForName:(NSString *)name {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
  NSArray *results = [self fetchRequestWithEntity:@"Host" andPredicate:predicate];
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
