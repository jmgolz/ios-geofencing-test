//
//  SaveRouteScreenViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "RouteStorageManager.h"
#import "RouteData.h"
#import "RouteCoordinate.h"

@interface SaveRouteScreenViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *routeNameTextField;
@property RouteStorageManager *routeStorageManager;
@property NSArray<id<MKAnnotation>> *annotationsForStorage;

- (IBAction)saveRoute:(id)sender;
- (IBAction)cancelRouteSave:(id)sender;
- (void)makeRouteSavedDialog:(BOOL)didSaveRecord;
@end
