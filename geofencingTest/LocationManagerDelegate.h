//
//  LocationManagerDelegate.h
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManagerDelegate : NSObject<CLLocationManagerDelegate>
-(BOOL)isUserCurrentlyInGeofence:(CLCircularRegion*)region currentLocationObject:(CLLocation *)currentLocation;
@end
