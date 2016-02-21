//
//  StoredRoutesScreenTableViewController.h
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoredRoutesTableDataSource.h"

@interface StoredRoutesScreenTableViewController : UITableViewController<UITableViewDelegate>
@property StoredRoutesTableDataSource *tableDataSource;
@end