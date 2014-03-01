//
//  JGWifiSetupViewController.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGBSSIDRanger.h"
#import "JGSetupProtocol.h"
#import <CoreLocation/CoreLocation.h>

@interface JGWifiSetupViewController : UITableViewController <JGBSSIDRangerDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *recordButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (nonatomic) NSString *locationDescription;


@end
