//
//  AlarmViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlarmKurViewController.h"
#import "AlarmObject.h"
#import "AFNetworking.h"

@interface AlarmViewController ()
@property (nonatomic) NSMutableArray *arrayOfAlarm;
@property (retain) IBOutlet UITableView *tableView;
@end

static NSString * const BaseURLString = @"http://api-dvzalt.azurewebsites.net/api/Notification/PostNotification";

@implementation AlarmViewController

@synthesize token;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue{
    AlarmKurViewController *source = [segue sourceViewController];
    AlarmObject *alarm = source.alarmObject;
    
    if (alarm != nil) {

        NSURL *baseURL = [NSURL URLWithString:BaseURLString];
        NSDictionary *parameters = @{@"Token" : self.token, @"CurrencyId" : [NSString stringWithFormat: @"%ld", (long)alarm.kurID], @"NotificationValue" : [NSString stringWithFormat: @"%f", alarm.kurAlis], @"Type" : [NSString stringWithFormat: @"%ld", (long)alarm.kurTur]};
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager POST:@"doviz-altin" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.arrayOfAlarm addObject:alarm];
            [self.tableView reloadData];
            NSLog(@"yeah: %@", responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Data alınırken hata oluştu"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Tamam"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfAlarm = [[NSMutableArray alloc] init];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
   
   // NSString *str = [[NSString alloc] initWithFormat: @"http://api-dvzalt.azurewebsites.net/api/User/AddUser?deviceId=%@&Type=1", uniqueIdentifier ];
   // NSLog(@"%@", uniqueIdentifier);
    
   // self.token = [NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSASCIIStringEncoding error:nil ];
     
   // NSLog(@"token: %@", self.token);
    
//    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alarmclockicon.png"]]];
//    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // NSLog(@"number of rows in section: %lu", self.arrayOfDovizInTheTable.count);
    return [self.arrayOfAlarm count];
}

//Gerekirse aç. Şimdilik gerek yok. Header ismi belirliyor.
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  //  return [NSString stringWithFormat:@"Kod \t \t \t \t \tAlış \tSatış"];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"DovizTableCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    // Configure the cell...
    AlarmObject *alarmObject =[self.arrayOfAlarm objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", alarmObject.kurKod];
    if(alarmObject.kurTur == 1)
        cell.textLabel.text = [NSString stringWithFormat:@"%.3f (Alış)", alarmObject.kurAlis];
    else
        cell.textLabel.text = [NSString stringWithFormat:@"%.3f (Satış)", alarmObject.kurAlis];
    cell.textLabel.font = [UIFont systemFontOfSize:30.0];
    
    //Indicator gerekirse burda:
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // NSLog(@"%f", kurObject.kurAlis);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.arrayOfAlarm removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
    [self.tableView setEditing:NO];
}
//
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:YES];
//    if (editing) {
//        addButton.enabled = NO;
//    } else {
//        addButton.enabled = YES;
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
