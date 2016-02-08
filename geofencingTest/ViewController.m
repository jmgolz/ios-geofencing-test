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
    // Do any additional setup after loading the view, typically from a nib.
    
    //Begin location monitoring
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManagerDelegate = [[LocationManagerDelegate alloc] init];
    self.locationManager.delegate = self.locationManagerDelegate;
    
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
    [self.locationManager startMonitoringForRegion:tampaGeoFence];
}


@end
