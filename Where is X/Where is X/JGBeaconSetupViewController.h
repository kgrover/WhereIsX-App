//
//  JGBeaconSetupViewController.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGSetupProtocol.h"

@interface JGBeaconSetupViewController : UIViewController <JGSetupProtocol>

@property (nonatomic) NSString *locationDescription;

@end
