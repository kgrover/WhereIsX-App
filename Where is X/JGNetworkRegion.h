//
//  CLNetworkRegion.h
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "JGNetworkData.h"

@interface JGNetworkRegion : CLRegion

@property (nonatomic, readonly) JGNetworkData *network;
@property (nonatomic, readonly) CLCircularRegion *circularRegion;

-(id)initWithNetworkData:(JGNetworkData*)network inCircularRegion:(CLCircularRegion*)region identifier:(NSString*)identifier;

@end