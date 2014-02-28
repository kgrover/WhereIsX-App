//
//  JGViewController.m
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGViewController.h"
#import "JGLocationManager.h"

#import "ARServerUpdater.h"

NSString * const JGBedroomBeaconUUID = @"23542266-18D1-4FE4-B4A1-23F8195B9D39";

NSString * const JGBedroomRegionIdentifier = @"com.JadenGeller.whereis.region.bedroom";

NSString * const JGLloydRegionIdentifier = @"com.JadenGeller.whereis.region.network.lloyd";
NSString * const JGRuddockRegionIdentifier = @"com.JadenGeller.whereis.region.network.ruddock";
NSString * const JGPageRegionIdentifier = @"com.JadenGeller.whereis.region.network.page";

NSString * const JGCaltechRegionIdentifier = @"com.JadenGeller.whereis.region.caltech";

CLLocationDegrees const JGCaltechLatitude = 34.13724130951865;
CLLocationDegrees const JGCaltechLongitude = -118.12534332275385;
CLLocationDistance const JGCaltechRadiusMeters = 621.9538056207171;

@interface JGViewController ()

@property (nonatomic) CLLocationManager *manager;
@property (nonatomic) CLBeaconRegion *bedroomRegion;
@property (nonatomic) CLCircularRegion *caltechRegion;

@property (nonatomic) BOOL inRoom;

@property (nonatomic) BOOL inLLoyd;
@property (nonatomic) BOOL inRuddock;
@property (nonatomic) BOOL inPage;

@property (nonatomic) BOOL onCampus;
@property (nonatomic) NSString *city;

@end

@implementation JGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ARServerUpdater *updater = [[ARServerUpdater alloc]initWithUsername:@"jgeller" password:@"12345"];
    [updater updateLocation:@"kind of hungry"];
    
    [self.manager startMonitoringSignificantLocationChanges];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(CLLocationManager*)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

-(CLBeaconRegion*)bedroomRegion{
    if (!_bedroomRegion) {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:JGBedroomBeaconUUID];
        _bedroomRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:JGBedroomRegionIdentifier];
    }
    return _bedroomRegion;
}

-(CLCircularRegion*)caltechRegion{
    if (!_caltechRegion) {
        _caltechRegion = [[CLCircularRegion alloc]initWithCenter:CLLocationCoordinate2DMake(JGCaltechLatitude, JGCaltechLongitude) radius:JGCaltechRadiusMeters identifier:JGCaltechRegionIdentifier];
    }
    return _caltechRegion;
}

-(void)updateDisplay{
         if (self.inRoom)    self.indicatorLabel.text = @"in your room";
    else if (self.inLLoyd)   self.indicatorLabel.text = @"in Lloyd";
    else if (self.inRuddock) self.indicatorLabel.text = @"in Ruddock";
    else if (self.inPage)    self.indicatorLabel.text = @"in Page";
    else if (self.onCampus)  self.indicatorLabel.text = @"on campus";
    else if (self.city)      self.indicatorLabel.text = [NSString stringWithFormat:@"in %@",self.city];
    else                     self.indicatorLabel.text = @"somewhere";
}

-(void)setInRoom:(BOOL)inRoom{
    if (inRoom != _inRoom) {
        _inRoom = inRoom;
        [self updateDisplay];
    }
}

-(void)setInLLoyd:(BOOL)inLLoyd{
    if (inLLoyd != _inLLoyd) {
        _inLLoyd = inLLoyd;
        [self updateDisplay];
    }
}

-(void)setInRuddock:(BOOL)inRuddock{
    if (inRuddock != _inRuddock) {
        _inRuddock = inRuddock;
        [self updateDisplay];
    }
}

-(void)setInPage:(BOOL)inPage{
    if (inPage != _inPage) {
        _inPage = inPage;
        [self updateDisplay];
    }
}

-(void)setOnCampus:(BOOL)onCampus{
    if (onCampus != _onCampus) {
        _onCampus = onCampus;
        [self updateDisplay];

    }
}

-(void)setCity:(NSString *)city{
    if (city != _city) {
        _city = city;
        [self updateDisplay];
    }
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = (state == CLRegionStateInside);
    }
    else if([region.identifier isEqualToString:JGCaltechRegionIdentifier]){
        self.onCampus = (state == CLRegionStateInside);
    }
    else if([region.identifier isEqualToString:JGLloydRegionIdentifier]){
        self.inLLoyd =  (state == CLRegionStateInside);
    }
    else if([region.identifier isEqualToString:JGRuddockRegionIdentifier]){
        self.inRuddock =  (state == CLRegionStateInside);
    }
    else if([region.identifier isEqualToString:JGPageRegionIdentifier]){
        self.inPage =  (state == CLRegionStateInside);
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = YES;
    }
    else if([region.identifier isEqualToString:JGCaltechRegionIdentifier]){
        self.onCampus = YES;
    }
    else if([region.identifier isEqualToString:JGLloydRegionIdentifier]){
        self.inLLoyd =  YES;
    }
    else if([region.identifier isEqualToString:JGRuddockRegionIdentifier]){
        self.inRuddock = YES;
    }
    else if([region.identifier isEqualToString:JGPageRegionIdentifier]){
        self.inPage = YES;
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = NO;
    }
    else if([region.identifier isEqualToString:JGBedroomRegionIdentifier]){
        self.onCampus = NO;
    }
    else if([region.identifier isEqualToString:JGLloydRegionIdentifier]){
        self.inLLoyd = NO;
    }
    else if([region.identifier isEqualToString:JGRuddockRegionIdentifier]){
        self.inRuddock = NO;
    }
    else if([region.identifier isEqualToString:JGPageRegionIdentifier]){
        self.inPage = NO;
    }
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"Error %@",error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *current = [locations lastObject];
    
    if ([self.caltechRegion containsCoordinate:current.coordinate]) self.onCampus = YES;
    
    CLGeocoder *geocode = [[CLGeocoder alloc]init];
    [geocode reverseGeocodeLocation:current completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = placemarks[0]; //disregard any other possible responses
        self.city = place.locality;
    }];
}

@end
