//
//  StoredRoutesScreenTableViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoredRoutesTableDataSource.h"
#import "SelectedRouteDetailViewController.h"
#import "RouteData.h"
#import "RouteCoordinate.h"


@interface StoredRoutesScreenTableViewController : UIViewController<UITableViewDelegate>
@property StoredRoutesTableDataSource * tableDataSource;
@property NSArray                     * routeDetailsForMapScreen;
@property RouteData                   * routeData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)returnToMap:(id)sender;
- (IBAction)prepareForUnwindToStoredRoutesList:(UIStoryboardSegue *)segue;
@end