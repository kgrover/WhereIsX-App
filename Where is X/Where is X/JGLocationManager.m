//
//  JGLocationManager.m
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGLocationManager.h"

@implementation JGLocationManager

+(BOOL)isMonitoringAvailableForClass:(Class)regionClass{
    return ([super isMonitoringAvailableForClass:regionClass] || [regionClass isSubclassOfClass:[JGNetworkRegion class]]);
}

-(void)requestStateForRegion:(CLRegion *)region{
    if ([region.class isSubclassOfClass:[JGNetworkRegion class]]) {
        
    }
    else{
        [super requestStateForRegion:region];
    }
}

-(void)startMonitoringForRegion:(CLRegion *)region{
    if ([region.class isSubclassOfClass:[JGNetworkRegion class]]) {
        
    }
    else{
        [super requestStateForRegion:region];
    }
}

-(void)stopMonitoringForRegion:(CLRegion *)region{
    if ([region.class isSubclassOfClass:[JGNetworkRegion class]]) {
        
    }
    else{
        [super requestStateForRegion:region];
    }
}

@end
