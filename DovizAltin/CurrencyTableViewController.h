//
//  DovizViewController.h
//  DovizAltin
//
//  Created by user30357 on 6/22/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, retain) NSArray *currencyArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSTimer *myTimer;


@end
