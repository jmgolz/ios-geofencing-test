//
//  SaveRouteScreenViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/19/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "SaveRouteScreenViewController.h"

@interface SaveRouteScreenViewController ()

@end

@implementation SaveRouteScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveRoute:(id)sender {
    [self makeRouteSavedDialog:YES];
}

- (IBAction)cancelRouteSave:(id)sender {

}

- (void)makeRouteSavedDialog:(BOOL)didSaveRecord{
    NSString *title;
    NSString *body;
    
    if(didSaveRecord == YES){
        title = @"Success!";
        body  = @"Successfully saved route.";
    } else {
        title = @"Error!";
        body  = @"There was a problem saving your route.";
    }
    UIAlertController *dialog = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    [dialog addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:dialog animated:YES completion:nil];
}
@end
