//
//  LocationManagerDelegate.m
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "LocationManagerDelegate.h"


@implementation LocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@",error.description);

}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *crnLoc = [locations lastObject];
    
    //Can we get zip code?
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:crnLoc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //NSLog(@"ZIP CODE: %@", [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"ZIP"]);
        
       // NSLog(@"lat: %f long: %f", crnLoc.coordinate.latitude, crnLoc.coordinate.longitude);
        //NSLog(@"Address: %@", [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"FormattedAddressLines"]);
    }];
    
    
    
    
}

//Delegate methods for geofencing
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Monitoring regions");
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"We made it! We are in %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"Exited the city of: %@", region.identifier);
}

-(BOOL)isUserCurrentlyInGeofence:(CLCircularRegion*)region currentLocationObject:(CLLocation *)currentLocation{
    
    return YES;
}

@end
