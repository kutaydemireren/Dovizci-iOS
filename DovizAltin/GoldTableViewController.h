//
//  AltinTableViewController.h
//  DovizAltin
//
//  Created by user30357 on 6/23/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, retain) NSArray *goldArray;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
