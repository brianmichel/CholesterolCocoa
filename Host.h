//
//  Host.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class FirewallRule;

@interface Host : NSManagedObject {

}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* Rule;
@property (nonatomic, retain) NSNumber * active;

@end

// coalesce these into one @interface Host (CoreDataGeneratedAccessors) section
@interface Host (CoreDataGeneratedAccessors)
- (void)addRuleObject:(FirewallRule *)value;
- (void)removeRuleObject:(FirewallRule *)value;
- (void)addRule:(NSSet *)value;
- (void)removeRule:(NSSet *)value;
@end
