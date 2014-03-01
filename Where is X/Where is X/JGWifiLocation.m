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
    [aCoder encodeObject:self.assoc
     iatedCircularRegion forKey:@"circularRegion"];
}

-(BOOL)isEqual:(id)object{
    return ([object isKindOfClass:[self class]] && [self.associatedCircularRegion isEqual:[object associatedCircularRegion]] && [self.networkData isEqual:[object networkData]]);
}

+(JGWifiLocation*)wifiLocationWithNetworkData:(NSArray*)networkData circularRegion:(CLCircularRegion*)region{
    return [[JGWifiLocation alloc]initWithNetworkData:networkData circularRegion:region];
}

- (id)copyWithZone:(NSZone *)zone{
    return [[JGWifiLocation allocWithZone:zone]initWithNetworkData:self.networkData circularRegion:self.associatedCircularRegion];
}

-(NSUInteger)hash{
    return self.networkData.hash + self.associatedCircularRegion.hash;
}

@end
