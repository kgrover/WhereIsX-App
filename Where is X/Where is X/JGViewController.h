//
//  JGViewController.h
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JGViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

@end
