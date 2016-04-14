//
//  StoredRoutesScreenTableCell.m
//  geofencingTest
//
//  Created by James Golz on 2/20/16.
//  Copyright © 2016 Sharks with Laser Spines. All rights reserved.
//

#import "StoredRoutesScreenTableCell.h"

@implementation StoredRoutesScreenTableCell

- (void)awakeFromNib {
    // Initialization code


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)loadMap:(UIButton*)button {
    NSLog(@"Row selected: %li", self.rowOfCustomCell.row);
    UITableView *table = [self tableView];
    [[table delegate] tableView:table didSelectRowAtIndexPath:self.rowOfCustomCell];
}
@end
