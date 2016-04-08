//
//  StoredRoutesScreenTableCell.h
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoredRoutesScreenTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentViewOfCell;
@property (weak, nonatomic) IBOutlet UILabel *dateSaved;
@property (weak, nonatomic) IBOutlet UILabel *routeAuthor;
@property (weak, nonatomic) IBOutlet UILabel *routeName;
@property (weak, nonatomic) IBOutlet UIButton *loadRouteButton;
@property (weak, nonatomic) IBOutlet UIButton *editRouteButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteRouteButton;

- (IBAction)loadMap:(id)sender;


@end
