//
//  AlarmKurViewController.h
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmObject.h"

@interface AlarmKurViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property AlarmObject *alarmObject;
@end
