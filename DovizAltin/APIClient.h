//
//  APIClient.h
//  DovizAltin
//
//  Created by user30357 on 7/3/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIClient : NSObject

+(void)AddUser;
+(void)GetJSONInformationFrom:(NSString *)URLString
                          success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
