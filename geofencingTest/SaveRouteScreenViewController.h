//
//  SaveRouteScreenViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveRouteScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *routeNameTextField;

- (IBAction)saveRoute:(id)sender;
- (IBAction)cancelRouteSave:(id)sender;
- (void)makeRouteSavedDialog:(BOOL)didSaveRecord;
@end
