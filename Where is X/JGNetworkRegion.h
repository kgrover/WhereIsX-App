//
//  CLNetworkRegion.h
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface JGNetworkRegion : CLRegion

@property (nonatomic, readonly) NSArray *networkData;
@property (nonatomic, readonly) CLCircularRegion *circularRegion;

-(id)initWithNetworkData:(NSArray*)networkData inCircularRegion:(CLCircularRegion*)region identifier:(NSString*)identifier;

@end