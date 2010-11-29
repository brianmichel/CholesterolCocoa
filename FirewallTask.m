//
//  FirewallTask.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirewallTask.h"
#define kIPFWPath @"/sbin/ipfw"

@implementation FirewallTask

@synthesize speed;
@synthesize loss;
@synthesize latency;
@synthesize endpoint;

- (id)initWithEndpoint:(NSString *)_endpoint speed:(NSNumber *)_speed packetloss:(NSNumber *)_loss latency:(NSNumber *)_latency  {
  if (!(self = [super init])) return self;
  self.speed = _speed;
  self.loss = _loss;
  self.endpoint = _endpoint;
  self.latency = _latency;
  return self;
}

- (void)main {
  NSLog(@"RUNNING LAUNCH TASK!");
  AuthorizationFlags myFlags;
  myFlags = kAuthorizationFlagDefaults |
  kAuthorizationFlagExtendRights |
  kAuthorizationFlagInteractionAllowed |
  kAuthorizationFlagPreAuthorize;
  
  AuthorizationItem items = {kAuthorizationRightExecute, 0, NULL, 0};
	AuthorizationRights rights = {1, &items};
  OSStatus myStatus = AuthorizationCreate(&rights, kAuthorizationEmptyEnvironment, myFlags, &authRef);
  [self launchTask];
}

- (void)launchTask {
  
  NSString *firstRuleString = [NSString stringWithFormat:@"add pipe %i ip from any to %@", 1, self.endpoint];
  NSTask *firstRule = [[[NSTask alloc] init] autorelease];
  [firstRule setLaunchPath:kIPFWPath];
  [firstRule setArguments:[NSArray arrayWithObjects:firstRuleString, nil]];
  [firstRule launch];
  
  NSString *secondRuleString = [NSString stringWithFormat:@"add pipe %i ip from %@ to any", 2, self.endpoint];
  NSTask *secondRule = [[[NSTask alloc] init] autorelease];
  [secondRule setLaunchPath:kIPFWPath];
  [secondRule setArguments:[NSArray arrayWithObjects:secondRuleString, nil]];
  [secondRule launch];
  
  NSString *thirdRuleString = [NSString stringWithFormat:@"pipe %i config delay %ims bw %iMBit/s plr %i", 1, [self.latency intValue], [self.speed intValue], [self.loss intValue]];
  NSTask *thirdRule = [[[NSTask alloc] init] autorelease];
  [thirdRule setLaunchPath:kIPFWPath];
  [thirdRule setArguments:[NSArray arrayWithObjects:thirdRuleString, nil]];
  [thirdRule launch];
  
  NSString *fourthRuleString = [NSString stringWithFormat:@"pipe %i config delay %ims bw %iMBit/s plr %i", 2, [self.latency intValue], [self.speed intValue], [self.loss intValue]];
  NSTask *fourthRule = [[[NSTask alloc] init] autorelease];
  [fourthRule setLaunchPath:kIPFWPath];
  [fourthRule setArguments:[NSArray arrayWithObjects:fourthRuleString, nil]];
  [fourthRule launch];
  
  AuthorizationFree(authRef, kAuthorizationFlagDestroyRights);
}

- (void)dealloc {
  [speed release];
  [loss release];
  [endpoint release];
  [latency release];
  [super dealloc];
}

@end
