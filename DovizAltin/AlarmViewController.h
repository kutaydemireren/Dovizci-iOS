//
//  AlarmViewController.h
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain) NSString *token;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
