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
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}
@end
