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

- (void)updateMap:(CGPoint)pointTouched locationManagerObject:(CLLocationManager*)locManager mapViewToUpdate:(MKMapView*)mapView{
    NSUInteger numberOfCheckpoints = [[locManager monitoredRegions] count];
    NSString *checkpointIdentifierString = [NSString stringWithFormat:@"Checkpoint %i", (unsigned int)(numberOfCheckpoints + 1)];
    MKPointAnnotation *annotationFromTouch = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordinateToAdd = [mapView convertPoint:pointTouched toCoordinateFromView:mapView];
    CLRegion *geofenceRegionFromDoubleTapGesture = [[CLCircularRegion alloc]
                                                    initWithCenter:coordinateToAdd radius:5 identifier:checkpointIdentifierString];
    
    
    annotationFromTouch.coordinate = coordinateToAdd;
    annotationFromTouch.title = checkpointIdentifierString;
    
    NSLog(@"coord: x:%f, y:%f", annotationFromTouch.coordinate.latitude, annotationFromTouch.coordinate.longitude);
    
    [mapView addAnnotation:annotationFromTouch];
    [locManager startMonitoringForRegion:geofenceRegionFromDoubleTapGesture];

}
@end