//
//  ViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/8/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegate.h"

@interface ViewController : UIViewController
@property CLLocationManager *locationManager;
@property LocationManagerDelegate *locationManagerDelegate;


@property (weak, nonatomic) IBOutlet UILabel *scansLabel;

- (IBAction)doScan:(id)sender;
- (void)handleLocationServicesAuthorizationCheck;
- (void)setUpGeoFences;

@end

