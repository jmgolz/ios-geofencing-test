//
//  EditRouteViewController.h
//  geofencingTest
//
//  Created by James Golz on 4/15/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RouteData.h"
#import "RouteCoordinate.h"
#import "RouteStorageManager.h"

@interface EditRouteViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *routeNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property RouteStorageManager *routeStorageManager;

- (IBAction)editRouteInformation:(UIButton *)sender;
@end
