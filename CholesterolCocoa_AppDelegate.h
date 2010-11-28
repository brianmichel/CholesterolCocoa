//
//  CholesterolCocoa_AppDelegate.h
//  CholesterolCocoa
//
//  Created by Brian Michel on 11/28/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CCMenu.h"
#import "CCStatusItem.h"

@interface CholesterolCocoa_AppDelegate : NSObject 
{
  NSWindow *window;
  
  IBOutlet CCMenu *menu;
  IBOutlet CCStatusItem *statusItem;
  
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, retain) CCStatusItem *statusItem;

- (IBAction)saveAction:sender;

@end
