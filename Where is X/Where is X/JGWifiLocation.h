//
//  JGWifiLocation.h
//  Where is X
//
//  Created by Jaden Geller on 2/28/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface JGWifiLocation : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) CLCircularRegion *associatedCircularRegion;
@property (nonatomic, readonly) NSArray *networkData;

-(id)initWithNetworkData:(NSArray*)networkData circularRegion:(CLCircularRegion*)region;
+(JGWifiLocation*)wifiLocationWithNetworkData:(NSArray*)networkData circularRegion:(CLCircularRegion*)region;
@end
