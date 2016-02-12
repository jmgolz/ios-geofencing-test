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
    CLLocationSpeed speedToUseAsZoomFactor = 1;
    CLLocationCoordinate2D emptyCoordinate;
    if(userLocation.location.speed){
        speedToUseAsZoomFactor = fabs(userLocation.location.speed * 1);
        
    }
    
    //MKCoordinateRegion updatedCoordinate = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, speedToUseAsZoomFactor, speedToUseAsZoomFactor);
    //MKCoordinateRegion updatedCoordinate = MKCoordinateRegionMakeWithDistance(emptyCoordinate, speedToUseAsZoomFactor, speedToUseAsZoomFactor);
    MKCoordinateRegion updatedCoordinate = { { 0.0f, 0.0f }, { 0.0f, 0.0f } };
    
    updatedCoordinate.center = userLocation.location.coordinate;
    updatedCoordinate.span.latitudeDelta = 0;
    updatedCoordinate.span.longitudeDelta = speedToUseAsZoomFactor;
    
    speedToUseAsZoomFactor = userLocation.location.speed * 1;
    //NSLog(@"Our speed: %f", speedToUseAsZoomFactor);
    
    //[mapView setRegion:updatedCoordinate animated:YES];
    //[mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    //[mapView regionThatFits:updatedCoordinate];
}
@end