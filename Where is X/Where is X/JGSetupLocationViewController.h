//
//  JGSetupLocationViewController.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGSetupLocationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *placeField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *signalType;

@end
