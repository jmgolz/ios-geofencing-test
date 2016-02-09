//
//  ViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Map init
    self.mapViewLocationManagerDelegate = [[MapViewLocationUpdatesDelegate alloc] init];
    self.mapView.delegate = self.mapViewLocationManagerDelegate;
    self.mapView.showsUserLocation = YES;    
    
    //[self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate];
    MKCoordinateRegion initialCoordinate = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 50, 50);
    
    [self.mapView setRegion:initialCoordinate animated:YES];
    
    //Begin location monitoring
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManagerDelegate = [[LocationManagerDelegate alloc] init];
    self.locationManager.delegate = self.locationManagerDelegate;
    
    //Get user permission to use location services, then start monitoring
    [self handleLocationServicesAuthorizationCheck];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doScan:(id)sender {
    [self handleLocationServicesAuthorizationCheck];
    self.scansLabel.text = @"Completed Scan";
}

- (void)handleLocationServicesAuthorizationCheck{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager requestAlwaysAuthorization];
            return;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            [self setUpGeoFences];
            return;
            
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            //[self showSorryAlert];
            return;
    }
}

-(void)setUpGeoFences{
    CLLocationCoordinate2D tampaGeoFenceCoords = CLLocationCoordinate2DMake(27.950575, -82.457178);
    CLRegion *tampaGeoFence = [[CLCircularRegion alloc] initWithCenter:tampaGeoFenceCoords radius:1000 identifier:@"tampa"];
    //[self.locationManager startMonitoringForRegion:tampaGeoFence];
    [self.locationManager startUpdatingLocation];
}


@end
