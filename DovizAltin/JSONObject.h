//
//  JSONObject.h
//  JSonDeneme
//
//  Created by user30357 on 6/22/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObject : NSObject{
   // NSString *kurKod;
   // NSInteger kurAlis;
   // NSInteger kurSatis;
}

@property (nonatomic, retain) NSString *rateCode;
@property (nonatomic, retain) NSString *rateTrName;
@property (assign) double rateBuyValue;
@property (assign) double rateSellValue;
@property (assign) int rateID;
@property (assign) BOOL rateIsSelected;

@end
