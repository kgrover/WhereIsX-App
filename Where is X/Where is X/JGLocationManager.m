//
//  JGLocationManager.m
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGLocationManager.h"

@interface JGLocationManager ()

@property (nonatomic) NSCountedSet *networkRegionHelpers;
@property (nonatomic) NSMutableArray *networkRegions;

@end

@implementation JGLocationManager

-(id)init{
    self = [super init];
    if (self) {
        [super setDelegate:self];
    }
    return self;
}

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
        if (![self.networkRegions containsObject:region]) {
            [self.networkRegions addObject:region];
            
            CLCircularRegion *helper = [(JGNetworkRegion*)region circularRegion];
            [self.networkRegionHelpers addObject:helper];
            
            if (![self.monitoredRegions containsObject:helper]) {
                [self startMonitoringForRegion:helper];
            }
        }
    }
    else{
        [super requestStateForRegion:region];
    }
}

-(void)stopMonitoringForRegion:(CLRegion *)region{
    if ([region.class isSubclassOfClass:[JGNetworkRegion class]]) {
        if ([self.networkRegions containsObject:region]) {
            [self.networkRegions removeObject:region];
            
            CLCircularRegion *helper = [(JGNetworkRegion*)region circularRegion];
            [self.networkRegionHelpers removeObject:helper];
            
            if ([self.networkRegionHelpers countForObject:helper] == 0) {
                [self stopMonitoringForRegion:helper];
            }
        }
    }
    else{
        [super requestStateForRegion:region];
    }
}

-(NSMutableArray*)networkRegions{
    if (!_networkRegions) {
        _networkRegions = [NSMutableArray array];
    }
    return _networkRegions;
}

-(NSCountedSet*)networkRegionHelpers{
    if (!_networkRegionHelpers) {
        _networkRegionHelpers = [NSCountedSet set];
    }
    return _networkRegionHelpers;
}

-(void)setDelegate:(id<CLLocationManagerDelegate>)delegate{
    [super setDelegate:delegate];
}

-(void)doesNotRecognizeSelector:(SEL)aSelector{
    if ([[self delegate] respondsToSelector:aSelector]) {
        // crazy stuff
    }
}

@end
