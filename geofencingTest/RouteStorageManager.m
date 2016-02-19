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
    //Create URL object that will point to the model file (geofencingTest.xcdatamodelid)
    NSURL *pathToRouteModelUrl = [[NSBundle mainBundle] URLForResource:@"geofencingTest" withExtension:@"momd"];
    
    //Load the model(s) from the model file, check model was correctly loaded
    self.routeStorageManagedObject = [[NSManagedObjectModel alloc] initWithContentsOfURL:pathToRouteModelUrl];
    NSAssert(self.routeStorageManagedObject != nil, @"Error intializing the route storage managed object model");
    
    //Instantiate the persistent store coordinator, object context
    self.routeStorageStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.routeStorageManagedObject];
    self.routeStorageDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.routeStorageDataContext setPersistentStoreCoordinator:self.routeStorageStoreCoordinator];
    
    //Fetch records?
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsUrl = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeUrl = [documentsUrl URLByAppendingPathComponent:@"geofencingTest.sqlite"];
    
    //Assign to main thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *error = nil;
        NSPersistentStoreCoordinator *routeStorageCoordinator = [[self routeStorageDataContext] persistentStoreCoordinator];
        NSPersistentStore *store = [routeStorageCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
        NSAssert(store != nil, @"Error initializing Persistent Store Coordinator: %@\n%@",error.localizedDescription, error.userInfo);
    });
}



@end
