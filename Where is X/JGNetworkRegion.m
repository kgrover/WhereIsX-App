//
//  CLNetworkRegion.m
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGNetworkRegion.h"

@interface JGNetworkRegion ()
{
    NSString *_identifier;
    BOOL _notifyOnEntry;
    BOOL _notifyOnExit;
}

@end

@implementation JGNetworkRegion

-(id)initWithNetworkData:(NSArray*)networkData inCircularRegion:(CLCircularRegion*)region identifier:(NSString*)identifier{
    self = [super init];
    if (self) {
        _networkData = networkData;
        _circularRegion = region;
        _identifier = identifier;
        
    }
    return self;
}

-(NSString*)identifier{
    return _identifier;
}

-(void)setNotifyOnEntry:(BOOL)notifyOnEntry{
    
}

-(void)setNotifyOnExit:(BOOL)notifyOnExit{
    
}

-(BOOL)notifyOnEntry{
    return _notifyOnEntry;
}

-(BOOL)notifyOnExit{
    return _notifyOnExit;
}

@end
