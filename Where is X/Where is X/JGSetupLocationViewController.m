//
//  JGSetupLocationViewController.m
//  Where is X
//
//  Created by Jaden Geller on 2/27/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGSetupLocationViewController.h"
#import "JGSetupProtocol.h"

@interface JGSetupLocationViewController ()

@end

@implementation JGSetupLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.setupButton.enabled = NO;
    [self.placeField becomeFirstResponder];
    [self.placeField addTarget:self action:@selector(editedPlace) forControlEvents:UIControlEventEditingChanged];
}

-(void)editedPlace{
    self.setupButton.enabled = self.placeField.text.length;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setupPress:(id)sender {
    NSString *segueIdentifier;
    switch (self.signalType.selectedSegmentIndex) {
        case 0:
            segueIdentifier = @"beaconSegue";
            break;
            
        case 1:
            segueIdentifier = @"wifiSegue";
            break;
            
        case 2:
            segueIdentifier = @"gpsSegue";
            break;
            
        default:
            return;
    }
    [self performSegueWithIdentifier:segueIdentifier sender:sender];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [(id <JGSetupProtocol>)segue.destinationViewController setLocationDescription:self.placeField.text];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self setupPress:nil];
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
