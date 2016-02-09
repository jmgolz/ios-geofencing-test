//
//  MapViewLocationUpdatesDelegate.m
//  geofencingTest
//
//  Created by James Golz on 2/9/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "MapViewLocationUpdatesDelegate.h"

@implementation MapViewLocationUpdatesDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationSpeed speedToUseAsZoomFactor = 50;
    
    if(userLocation.location.speed){
        speedToUseAsZoomFactor = [[NSNumber numberWithDouble:fabs(userLocation.location.speed * 100)] integerValue];
    }
    
    MKCoordinateRegion updatedCoordinate = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, speedToUseAsZoomFactor, speedToUseAsZoomFactor);
    
    
    //NSLog(@"Our speed: %f", userLocation.location.speed);
    NSLog(@"Our speed: %f", speedToUseAsZoomFactor);
    [mapView setRegion:updatedCoordinate animated:YES];
    //[mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}
@end
