//
//  JGWifiLocation.m
//  Where is X
//
//  Created by Jaden Geller on 2/28/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGWifiLocation.h"

@implementation JGWifiLocation

-(id)initWithNetworkData:(NSArray*)networkData circularRegion:(CLCircularRegion*)region{
    self = [super init];
    if (self) {
        _networkData = networkData;
        _associatedCircularRegion = region;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return [self initWithNetworkData:[aDecoder decodeObjectForKey:@"networkData"] circularRegion:[aDecoder decodeObjectForKey:@"circularRegion"]];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.networkData forKey:@"networkData"];
    [aCoder encodeObject:self.associatedCircularRegion forKey:@"circularRegion"];
}

@end
