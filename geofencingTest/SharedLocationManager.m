//
//  SharedLocationManager.m
//  geofencingTest
//
//  Created by James Golz on 3/29/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "SharedLocationManager.h"

@implementation SharedLocationManager
+(SharedLocationManager *) sharedInstance{
    static SharedLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(id) init{
    self = [super init];
    if (self != nil) {
        self.locationManager                    = [[CLLocationManager alloc]init];
        self.locationManagerDelegate            = [[LocationManagerDelegate alloc] init];
        self.locationManager.delegate           = self.locationManagerDelegate;
        self.locationManager.desiredAccuracy    = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager requestAlwaysAuthorization];
    }
    return self;
}

-(void) clearAllMonitoredRegions{
    for (CLCircularRegion *region in self.locationManager.monitoredRegions) {
        [self.locationManager stopMonitoringForRegion:region];
    }
    
    if (self.monitoredRegions) {
        self.monitoredRegions = nil;
    }
}

-(void) addMonitoredRegions:(NSArray<CLCircularRegion*> *)regions{
    self.monitoredRegions = [NSArray arrayWithArray:regions];
    
    for (CLCircularRegion *region in regions) {
        [self.locationManager startMonitoringForRegion:region];
    }
}

-(NSSet *)getMonitoredRegions{
    return self.locationManager.monitoredRegions;
}

-(void) addRegionToMonitor:(CLCircularRegion *)region{
    [self.locationManager startMonitoringForRegion:region];
    self.monitoredRegions = [self.monitoredRegions arrayByAddingObject:region];
}
@end