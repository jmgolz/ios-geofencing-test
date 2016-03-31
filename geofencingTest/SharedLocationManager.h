//
//  SharedLocationManager.h
//  geofencingTest
//
//  Created by James Golz on 3/29/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegate.h"

@interface SharedLocationManager : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray           *monitoredRegions;
@property (strong, nonatomic) LocationManagerDelegate *locationManagerDelegate;

+(SharedLocationManager *) sharedInstance;
-(void) clearAllMonitoredRegions;
-(void) addMonitoredRegions:(NSArray *)regions;
-(void) addRegionToMonitor:(CLCircularRegion *)region;
-(NSSet *)getMonitoredRegions;
@end
