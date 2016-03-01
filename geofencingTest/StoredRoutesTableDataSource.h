//
//  StoredRoutesTableDataSource.h
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "StoredRoutesScreenTableCell.h"
#import "RouteStorageManager.h"
#import "RouteData.h"
#import "RouteCoordinate.h"

@interface StoredRoutesTableDataSource : NSObject<UITableViewDataSource>
@property RouteStorageManager *storedRoutes;
@property StoredRoutesScreenTableCell *tableCell;
@property NSArray *fetchResults;


- (void)getDataSet;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
