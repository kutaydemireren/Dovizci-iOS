//
//  AlarmKurViewController.m
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "AlarmKurViewController.h"

@interface AlarmKurViewController ()
@property (retain) NSArray *dcJSON;
@property (retain) NSMutableArray *pickerData;
@property (retain) NSMutableArray *pickerIDData;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@end

@implementation AlarmKurViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerData = [[NSMutableArray alloc] init];
    
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

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSInteger row;
    if(sender != self.saveButton) return;
    if (self.textField.text.length > 0) {
        self.alarmObject = [[AlarmObject alloc] init];
        self.alarmObject.kurAlis = [self.textField.text doubleValue];
       // NSLog(@"alış: %f", self.alarmObject.kurAlis);
        row = [self.picker selectedRowInComponent:0];  // row + 1 = currencyID;
        self.alarmObject.kurKod = [self.pickerData objectAtIndex:row];
       // NSLog(@"kod: %@", self.alarmObject.kurKod);
        self.alarmObject.kurTur = [self.segmentedControl selectedSegmentIndex]+1;
      //  NSLog(@"kur id: %ld", row+1); // row + 1 = currencyID;
        if(row+1 < 15){
            self.alarmObject.kurID = (row+1)+20;
        }else{
            self.alarmObject.kurID = (row+1)-14;
        }
        NSLog(@"ismi: %lu", (long)self.alarmObject.kurID);
    }
}


@end
