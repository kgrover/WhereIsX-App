//
//  ARServerUpdater.m
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "ARServerUpdater.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import <Parse/Parse.h>

NSString * const ARServerURL = @"http://alex.caltech.edu:5000";

@interface ARServerUpdater ()

@property (nonatomic) AFHTTPRequestOperationManager *manager;
@property (nonatomic) NSString *username;

@end

@implementation ARServerUpdater

-(id)initWithUsername:(NSString*)username password:(NSString*)password{
    if (self = [super init]) {
        _username = username;
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:ARServerURL]];
        
        _manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        
        // set username and password
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        [serializer clearAuthorizationHeader];
        [serializer setAuthorizationHeaderFieldWithUsername:username password:password];
        _manager.requestSerializer = serializer;
        
    }
    return self;
}

-(void)updateLocation:(NSString*)location{
//    [self.manager GET:[NSString stringWithFormat:@"/update_location/%@/%@",self.username,[location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil success:nil failure:nil];
    
    PFObject *testObject = [PFObject objectWithClassName:@"LocationObject"];
    testObject[@"locationString"] = [NSString stringWithFormat:@"%@", location];
    [testObject saveInBackground];
    
    
}

@end
