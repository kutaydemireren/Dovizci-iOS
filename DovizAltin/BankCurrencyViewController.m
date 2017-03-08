//
//  BankCurrencyViewController.m
//  DovizAltin
//
//  Created by Murat on 14/07/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "BankCurrencyViewController.h"
#import "APIClient.h"

@interface BankCurrencyViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *bankCurrencyArray;
@end

@implementation BankCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerData = [[NSArray alloc] initWithObjects:@"Amerikan Doları", @"Euro", @"İngiliz Sterlini", @"İsveç Kronu", @"Suudi Arabistan Riyali", @"Norveç Kronu", @"Kuveyt Dinarı", @"100 Japon Yeni", @"Danimarka Kronu", @"İsviçre Frangı", @"Kanada Doları", @"Avustralya Doları",  nil];
    [self uploadInitialBankData];
    
}

-(void)uploadInitialBankData{
    
    NSString *URL = @"http://api-dvzalt.azurewebsites.net/api/Currency/BankDoviz?currencyId=5"; //Picker starts with "Amerikan Doları", which has the CurrencyID of 5.

    [APIClient GetJSONInformationFrom:URL
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self updateBankCurrencyArrayWithDictionary:responseObject];
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"Failure: %@", error);
                              }];
}

-(void)updateBankCurrencyArrayWithDictionary:(NSDictionary *)dictionary{
    self.bankCurrencyArray = [[NSArray alloc] initWithArray:dictionary[@"Data"]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"The number URL will take: %ld", (long)row+5);
    NSString *URL =  [[NSString alloc] initWithFormat: @"http://api-dvzalt.azurewebsites.net/api/Currency/BankDoviz?currencyId=%ld", (long)row+5]; //API needs 5 bigger count than normal count, to be able to give the data.

    [APIClient GetJSONInformationFrom:URL
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self updateBankCurrencyArrayWithDictionary:responseObject];
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  NSLog(@"Failure in bank currency: %@", error);
                              }];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *) view;
    if(pickerLabel == nil)
    {
        CGRect frame = CGRectMake(0.0, 0.0, 300.0, 300.0);
        pickerLabel = [[UILabel alloc ] initWithFrame:frame];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
        pickerLabel.textColor = [UIColor orangeColor];
    }
    [pickerLabel setText: [self.pickerData objectAtIndex:row]];
    return pickerLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //One whole list.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // NSLog(@"number of rows: %lu", self.currencyArray.count);
    return [self.bankCurrencyArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Kod\t\t\t\t\tAlış\tSatış"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"BankCurrencyTableCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    // Configure the cell...
    NSString *bankName =[self.bankCurrencyArray objectAtIndex:indexPath.row][@"BankName"];
    NSString *rateBuyValue = [self.bankCurrencyArray objectAtIndex:indexPath.row][@"BuyValue"];
    NSString *rateSellValue = [self.bankCurrencyArray objectAtIndex:indexPath.row][@"SellValue"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@\t\t\t\t\t%.3f\t%.3f", bankName, [rateBuyValue doubleValue], [rateSellValue doubleValue]];
    
    return cell;
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
