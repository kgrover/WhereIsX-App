//
//  JGLocationManager.h
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "JGNetworkRegion.h" 

extern NSTimeInterval const JGLocationManagerSearchIntervalMinimum;

@interface JGLocationManager : CLLocationManager <CLLocationManagerDelegate>

@property (nonatomic) NSTimeInterval searchInterval;

@end
