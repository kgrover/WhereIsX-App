//
//  JGLocationManager.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JGLocationManagerDelegate <NSObject>

-(void)locationChanged:(NSString*)locationString;

@end

@interface JGLocationManager : NSObject

@property (nonatomic) NSString *locationString;

@property (nonatomic) id<JGLocationManagerDelegate> delegate;

@end
