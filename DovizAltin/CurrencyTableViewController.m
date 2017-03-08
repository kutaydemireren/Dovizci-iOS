//
//  DovizViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/22/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "CurrencyTableViewController.h"
#import "JSONObject.h"
#import "CurrencyDetailViewController.h"
#import "APIClient.h"

@interface CurrencyTableViewController ()
@property (retain) NSArray *dcJSON;
@end

@implementation CurrencyTableViewController

@synthesize currencyArray, tableView;


- (NSArray *) currencyArray{
    return currencyArray;
} 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
   
   
    NSString *URL = @"http://api-dvzalt.azurewebsites.net/api/Currency/Doviz";
    
    [APIClient GetJSONInformationFrom:URL
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      [self updateCurrencyArrayWithDictionary:responseObject];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Failure: %@", error);
                                  }];
    
    
//    Timer. Will be opened, later.
//   self.myTimer = [NSTimer scheduledTimerWithTimeInterval:15
//                                                        target:self
//                                                      selector:@selector(updateTable)
//                                                      userInfo:nil
//                                                       repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
}

-(void)updateCurrencyArrayWithDictionary:(NSDictionary *)dictionary{
    currencyArray = [[NSArray alloc] initWithArray:dictionary[@"Data"]];
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
    // NSLog(@"number of rows: %lu", self.currencyArray.count);
    return [self.currencyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"ReuseIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    // Configure the cell...
    NSString *rateCode =[self.currencyArray objectAtIndex:indexPath.row][@"CurrencyShortName"];
    rateCode = [rateCode substringFromIndex:1]; //Throws S at the beginning: SUSD => USD.
    NSString *rateBuyValue = [self.currencyArray objectAtIndex:indexPath.row][@"BuyValue"];
    NSString *rateSellValue = [self.currencyArray objectAtIndex:indexPath.row][@"SellValue"];
    
    UILabel *label;
    
    label = (UILabel *)[cell viewWithTag:1];
    label.text = [NSString stringWithFormat:@"%@",  rateCode];
    
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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrencyDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [self.navigationController pushViewController:detail animated:YES];
}
*/

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
