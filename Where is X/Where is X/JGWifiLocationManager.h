//
//  JGWifiLocationManager.h
//  Where is X
//
//  Created by Jaden Geller on 2/28/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "JGBSSIDRanger.h"

@class JGWifiLocation, JGWifiLocationManager;

@protocol JGWifiLocationManagerDelegate <NSObject>

-(void)locationManager:(JGWifiLocationManager*)manager didEnterLocation:(JGWifiLocation*)location;
-(void)locationManager:(JGWifiLocationManager*)manager didExitLocation:(JGWifiLocation*)location;

@end

@interface JGWifiLocationManager : NSObject <CLLocationManagerDelegate, JGBSSIDRangerDelegate>

-(void)startMonitoringForLocation:(JGWifiLocation*)location;
-(void)stopMonitoringForLocation:(JGWifiLocation*)location;


@property (nonatomic, weak) id<JGWifiLocationManagerDelegate> delegate;

@property (nonatomic,readonly) BOOL ranging;
@property (nonatomic) NSTimeInterval searchInterval;

@end
