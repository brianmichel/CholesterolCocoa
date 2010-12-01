//
//  FirewallTask.m
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirewallTask.h"
#define kIPFWPath @"/sbin/ipfw"
#define kSudoPath @"/usr/bin/sudo"

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
  if (myStatus == noErr) {
    [self launchTask];
  } else {
    NSRunAlertPanel(@"Authentication Error", @"Cholesterol needs to authenticate to add the rule.", @"", @"Cancel", NULL);
  }

}

- (void)launchTask {
  setuid(0);
  //AuthorizationRef auth = NULL;
  //OSStatus junk = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, kAuthorizationFlagInteractionAllowed, &auth);
  
  NSString *firstRuleString = [NSString stringWithFormat:@"ipfw add pipe %i ip from any to %@", 1, self.endpoint];
  NSArray *ruleArray = [firstRuleString componentsSeparatedByString:@" "];
  NSTask *firstRule = [[[NSTask alloc] init] autorelease];
  [firstRule setLaunchPath:kSudoPath];
  [firstRule setArguments:ruleArray];
  [firstRule launch];
  
  NSString *secondRuleString = [NSString stringWithFormat:@"ipfw add pipe %i ip from %@ to any", 2, self.endpoint];
  ruleArray = [secondRuleString componentsSeparatedByString:@" "];
  NSTask *secondRule = [[[NSTask alloc] init] autorelease];
  [secondRule setLaunchPath:kSudoPath];
  [secondRule setArguments:ruleArray];
  [secondRule launch];
  
  NSString *thirdRuleString = [NSString stringWithFormat:@"ipfw pipe %i config delay %ims bw %iMBit/s plr %i", 1, [self.latency intValue], [self.speed intValue], [self.loss intValue]];
  ruleArray = [thirdRuleString componentsSeparatedByString:@" "];
  NSTask *thirdRule = [[[NSTask alloc] init] autorelease];
  [thirdRule setLaunchPath:kSudoPath];
  [thirdRule setArguments:ruleArray];
  [thirdRule launch];
  
  NSString *fourthRuleString = [NSString stringWithFormat:@"ipfw pipe %i config delay %ims bw %iMBit/s plr %i", 2, [self.latency intValue], [self.speed intValue], [self.loss intValue]];
  ruleArray = [fourthRuleString componentsSeparatedByString:@" "];
  NSTask *fourthRule = [[[NSTask alloc] init] autorelease];
  [fourthRule setLaunchPath:kSudoPath];
  [fourthRule setArguments:ruleArray];
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
