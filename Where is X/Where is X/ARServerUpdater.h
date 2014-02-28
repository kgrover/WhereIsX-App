//
//  ARServerUpdater.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARServerUpdater : NSObject

-(void)updateLocation:(NSString*)location;
-(id)initWithUsername:(NSString*)username password:(NSString*)password;

@end
