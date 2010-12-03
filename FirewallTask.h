//
//  FirewallTask.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Host.h"

typedef enum FirewallTaskStyle {
  FirewallTaskFlush = 0,
  FirewallTaskCreate,
  FirewallTaskRemove
} FirewallTaskStyle;

@interface FirewallTask : NSOperation {
  FirewallTaskStyle style;
  Host *host;
  NSNumber *speed;
  NSNumber *loss;
  NSNumber *latency;
  NSString *endpoint;
  AuthorizationRef authRef;
  BOOL success;
}

@property (nonatomic, assign) FirewallTaskStyle style;
@property (nonatomic, retain) Host *host;
@property (nonatomic, retain) NSString *endpoint;
@property (nonatomic, retain) NSNumber *speed;
@property (nonatomic, retain) NSNumber *loss;
@property (nonatomic, retain) NSNumber *latency;
@property (nonatomic, assign) BOOL success;

- (id)initWithEndpoint:(NSString *)_endpoint speed:(NSNumber *)_speed packetloss:(NSNumber *)_loss latency:(NSNumber *)_latency namedHost:(Host *)_host namedStyle:(FirewallTaskStyle)_style;
- (void)launchTask;

@end
