//
//  DovizDetailViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "CurrencyDetailViewController.h"

@interface CurrencyDetailViewController ()

@end

@implementation CurrencyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Kod \t \t \t \t \t \tAlış \t\tSatış"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
