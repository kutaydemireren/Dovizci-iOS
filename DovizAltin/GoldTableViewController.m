//
//  AltinTableViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/23/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "GoldTableViewController.h"
#import "JSONObject.h"
#import "APIClient.h"

@interface GoldTableViewController ()

@end

@implementation GoldTableViewController

@synthesize goldArray, tableView;

- (NSArray *) goldArray{
    return goldArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *URL = @"http://api-dvzalt.azurewebsites.net/api/Currency/Altin";
    
    [APIClient GetJSONInformationFrom:URL
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      [self updateGoldArrayWithDictionary:responseObject];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Failure Gold: %@", error);
                                  }];
    
    
    //Timer. Will be opened, later.
    //   self.myTimer = [NSTimer scheduledTimerWithTimeInterval:15
    //                                                      target:self
    //                                                  selector:@selector(updateTable)
    //                                                userInfo:nil
    //                                               repeats:YES];
    // [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
}

-(void)updateGoldArrayWithDictionary:(NSDictionary *)dictionary{
    goldArray = [[NSArray alloc] initWithArray:dictionary[@"Data"]];
    [self.tableView reloadData];
}

- (void) updateTable{
    [tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //One whole list.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // NSLog(@"number of rows in section: %lu", self.arrayOfDovizInTheTable.count);
    return [self.goldArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"ReuseIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    // Configure the cell...
    NSString *rateName =[self.goldArray objectAtIndex:indexPath.row][@"CurrencyName"];
    NSString *rateBuyValue = [self.goldArray objectAtIndex:indexPath.row][@"BuyValue"];
    NSString *rateSellValue = [self.goldArray objectAtIndex:indexPath.row][@"SellValue"];
    
    UILabel *label;

    label = (UILabel *)[cell viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%@",  rateName];
    
    label = (UILabel *)[cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"%.3f",  [rateBuyValue doubleValue]];
    
    label = (UILabel *)[cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"%.3f",  [rateSellValue doubleValue]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *identifier = @"HeaderCell";
    UITableViewCell *header =[self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    [header setBackgroundColor:[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]];
    
    UILabel *label;

    label = (UILabel *)[header viewWithTag:4];
    label.text = [NSString stringWithFormat:@"Kur"];
    
    label = (UILabel *)[header viewWithTag:5];
    label.text = [NSString stringWithFormat:@"Alış"];
    
    label = (UILabel *)[header viewWithTag:6];
    label.text = [NSString stringWithFormat:@"Satış"];
    return header;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DovizDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
//    [self.navigationController pushViewController:detail animated:YES];
//}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
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
