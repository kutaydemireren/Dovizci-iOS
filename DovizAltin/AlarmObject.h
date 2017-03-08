//
//  AlarmObject.h
//  DovizAltin
//
//  Created by user30357 on 6/24/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmObject : NSObject

@property (retain) NSString *kurKod;
@property (assign) float kurAlis;
@property (assign) NSInteger kurTur; // 1 = Alış , 2 = Satış
@property (assign) NSInteger kurID;

@end
