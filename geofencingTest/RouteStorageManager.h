//
//  RouteStorageManager.h
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RouteStorageManager : NSObject
@property NSManagedObjectContext *routeStorageDataContext;
@property NSManagedObjectModel *routeStorageManagedObject;
@property NSPersistentStoreCoordinator *routeStorageStoreCoordinator;

- (void)initializeCoreData;
@end
