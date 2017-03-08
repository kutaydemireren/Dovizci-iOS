//
//  APIClient.m
//  DovizAltin
//
//  Created by user30357 on 7/3/15.
//  Copyright (c) 2015 user30357. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+(void)AddUser{
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; //DeviceID
    
    NSDictionary *params = @{@"DeviceId" : uniqueIdentifier, @"Type" : [NSNumber numberWithInt:1]};
    
    /*
     //To check if params dic. is in the correct form, JSON.
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
     options:NSJSONWritingPrettyPrinted
     error:nil];
     NSString* aStr;
     aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     NSLog(@"JSON: %@", aStr);
    */
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://api-dvzalt.azurewebsites.net/users";
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //Sets the neccessary user informations.
        [defaults setObject:responseObject[@"Data"][@"AccessToken"] forKey:@"accessToken"];
        [defaults setObject:responseObject[@"Data"][@"Id"] forKey:@"ID"];
        [defaults setObject:responseObject[@"Data"][@"IsUser"] forKey:@"isUser"];
         NSLog(@"access token add user: %@", responseObject[@"Data"][@"AccessToken"]);
        // NSLog(@"id: %@", [defaults objectForKey:@"ID"]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

+(void)GetJSONInformationFrom:(NSString *)URLString
                          success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure

{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; // User informations.
    NSString *accessToken = [defaults objectForKey:@"accessToken"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"Token"];
    
     NSLog(@"access token json inf: %@", accessToken);
    // NSLog(@"id: %@", [defaults objectForKey:@"ID"]);

    [manager GET:URLString parameters:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
            success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(operation, error);
    }];
}


@end
