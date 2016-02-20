//
//  RouteStorageManager.m
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "RouteStorageManager.h"

@implementation RouteStorageManager
-(id)init{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self initializeCoreData];
    return self;
}

- (void)initializeCoreData{
    NSManagedObjectModel *routeDataModel = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    
    NSPersistentStoreCoordinator *routeDataPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:routeDataModel];
    
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Database.sqlite"];
    
    [routeDataPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    
    self.routeStorageDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.routeStorageDataContext.persistentStoreCoordinator = routeDataPersistentStoreCoordinator;

}
@end