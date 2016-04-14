//
//  StoredRoutesScreenTableViewController.m
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "StoredRoutesScreenTableViewController.h"

@interface StoredRoutesScreenTableViewController ()

@end

@implementation StoredRoutesScreenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableDataSource      = [[StoredRoutesTableDataSource alloc] init];
    self.tableView.dataSource = self.tableDataSource;
    self.tableView.delegate   = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    self.routeData = [self.tableDataSource.fetchResults objectAtIndex:indexPath.row];
    
    
    
    [self performSegueWithIdentifier:@"segueToDetailVew" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"segueToDetailVew"]){
        [(SelectedRouteDetailViewController*)[segue destinationViewController] setRouteData:self.routeData];
    } else if([[segue identifier] isEqualToString:@"segueToMainMapVew"]){
        
    }
}

-(IBAction)prepareForUnwindToStoredRoutesList:(UIStoryboardSegue *)segue {
    if ([[[segue sourceViewController] restorationIdentifier] isEqualToString:@"routeDetail"]) {
        self.routeData = [(SelectedRouteDetailViewController*)[segue destinationViewController] routeData];
    }
}


- (IBAction)returnToMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
