//
//  JGConfigureLocationViewController.h
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGLocationManager;

@protocol JGConfigureLocationProtocol <NSObject>

-(void)hiddenChanged;

@end

@interface JGConfigureLocationViewController : UITableViewController

@property (nonatomic) JGLocationManager *manager;
@property (nonatomic) NSMutableDictionary *locationStrings;

-(void)addLocation:(NSObject<NSCopying>*)location withDescription:(NSString*)description;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hiddenButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) id <JGConfigureLocationProtocol>delegate;

@end
