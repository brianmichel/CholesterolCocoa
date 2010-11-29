//
//  FirewallRule.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Host;

@interface FirewallRule : NSManagedObject {

}

@property (nonatomic, retain) NSNumber * connectionLatency;
@property (nonatomic, retain) NSString * endpoint;
@property (nonatomic, retain) NSNumber * networkSpeed;
@property (nonatomic, retain) NSNumber * packetLossRatio;
@property (nonatomic, retain) NSNumber * pipeNumber;
@property (nonatomic, retain) Host * host;

@end

