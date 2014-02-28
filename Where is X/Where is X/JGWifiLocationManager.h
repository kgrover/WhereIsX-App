//
//  JGWifiLocationManager.h
//  Where is X
//
//  Created by Jaden Geller on 2/28/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGWifiLocation.h"

@interface JGWifiLocationManager : NSObject

-(void)startMonitoringForLocation:(JGWifiLocation*)location;
-(void)stopMonitoringForLocation:(JGWifiLocation*)location;

@end
