//
//  JGLocationManager.m
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGLocationManager.h"
#import "JGWifiLocation.h"
#import "JGWifiLocationManager.h"

NSString * const JGLocationsArrayKey = @"com.whereis.locations.saved";

@interface JGLocationManager ()

{
    NSMutableArray *_locations;
}

@property (nonatomic) CLLocationManager *regionManager;
@property (nonatomic) JGWifiLocationManager *wifiManager;

@end

@implementation JGLocationManager

-(id)init{
    if (self = [super init]) {
        _locations = [[NSUserDefaults standardUserDefaults]arrayForKey:JGLocationsArrayKey].mutableCopy;
        
        [self trackAllLocations];
    }
    return self;
}

-(void)trackAllLocations{
    for (NSObject *obj in self.locations) [self trackLocation:obj];
}

-(void)trackLocation:(NSObject*)location{
    if ([location isKindOfClass:[CLRegion class]]) {
        [self.regionManager startMonitoringForRegion:(CLRegion*)location];
    }
    else if([location isKindOfClass:[JGWifiLocation class]]){
        [self.wifiManager startMonitoringForLocation:(JGWifiLocation*)location];
    }
}

-(void)addLocation:(NSObject*)location{
    [_locations addObject:location];
    [self trackLocation:location];
    [self save];
}

-(void)stopTrackingLocation:(NSObject*)location{
    if ([location isKindOfClass:[CLRegion class]]) {
        [self.regionManager stopMonitoringForRegion:(CLRegion*)location];
    }
    else if([location isKindOfClass:[JGWifiLocation class]]){
        [self.wifiManager stopMonitoringForLocation:(JGWifiLocation*)location];
    }
}

-(void)removeLocationAtIndex:(NSInteger)index{
    NSObject *location = [self.locations objectAtIndex:index];
    [self stopTrackingLocation:location];
    [_locations removeObjectAtIndex:index];
    [self save];
}

-(void)moveLocationAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex{
    NSObject *obj = [self.locations objectAtIndex:oldIndex];
    [_locations removeObjectAtIndex:oldIndex];
    [_locations insertObject:obj atIndex:newIndex];
}

-(NSMutableArray*)locations{
    return _locations.copy;
}

-(CLLocationManager*)regionManager{
    if (_regionManager) {
        _regionManager = [[CLLocationManager alloc]init];
        _regionManager.delegate = self;
    }
    return _regionManager;
}

-(JGWifiLocationManager*)wifiManager{
    if (!_wifiManager) {
        _wifiManager = [[JGWifiLocationManager alloc]init];
    }
    return _wifiManager;
}

-(void)save{
    [[NSUserDefaults standardUserDefaults] setObject:self.locations forKey:JGLocationsArrayKey];
}


@end
