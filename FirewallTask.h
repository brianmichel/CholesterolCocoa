//
//  FirewallTask.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FirewallTask : NSOperation {
  NSNumber *speed;
  NSNumber *loss;
  NSNumber *latency;
  NSString *endpoint;
  AuthorizationRef authRef;
}

@property (nonatomic, retain) NSString *endpoint;
@property (nonatomic, retain) NSNumber *speed;
@property (nonatomic, retain) NSNumber *loss;
@property (nonatomic, retain) NSNumber *latency;

- (id)initWithEndpoint:(NSString *)_endpoint speed:(NSNumber *)_speed packetloss:(NSNumber *)_loss latency:(NSNumber *)_latency;
- (void)launchTask;

@end
