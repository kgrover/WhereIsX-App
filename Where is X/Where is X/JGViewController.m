//
//  JGViewController.m
//  Where is X
//
//  Created by Jaden Geller on 2/25/14.
//  Copyright (c) 2014 Jaden Geller. All rights reserved.
//

#import "JGViewController.h"
#import "JGLocationManager.h"

NSString * const JGBedroomBeaconUUID = @"23542266-18D1-4FE4-B4A1-23F8195B9D39";

NSString * const JGBedroomRegionIdentifier = @"com.JadenGeller.whereis.region.bedroom";
//NSString * const JGLloydRegionIdentifier = @"com.JadenGeller.whereis.region.network.lloyd";
NSString * const JGCaltechRegionIdentifier = @"com.JadenGeller.whereis.region.caltech";

CLLocationDegrees const JGCaltechLatitude = 34.13724130951865;
CLLocationDegrees const JGCaltechLongitude = -118.12534332275385;
CLLocationDistance const JGCaltechRadiusMeters = 621.9538056207171;

//typedef NS_ENUM(NSInteger, JGNetworkLocation){
//    JGCampusLocationNone,
//    JGHouseHome,
//    JGHouseLloyd,
//    JGHouseRuddock,
//    JGHousePage,
//    JGHouseBlacker,
//    JGHouseRickets,
//    JGHouseDabney,
//    JGHouseFlemming,
//    JGHouseAvery
//};

@interface JGViewController ()

@property (nonatomic) JGLocationManager *manager;
@property (nonatomic) CLBeaconRegion *bedroomRegion;
@property (nonatomic) JGNetworkRegion *networkRegion;
@property (nonatomic) CLCircularRegion *caltechRegion;

@property (nonatomic) BOOL inRoom;
//@property (nonatomic) JGNetworkLocation networkLocation;
@property (nonatomic) BOOL onCampus;
@property (nonatomic) NSString *city;

@end

@implementation JGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.manager startMonitoringForRegion:self.bedroomRegion];
    [self.manager startMonitoringForRegion:self.caltechRegion];
    //[self.manager startMonitoringForRegion:self.networkRegion];
    
    [self.manager startMonitoringSignificantLocationChanges];
    
    [self.manager requestStateForRegion:self.caltechRegion];
    [self.manager requestStateForRegion:self.bedroomRegion];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(JGLocationManager*)manager{
    if (!_manager) {
        _manager = [[JGLocationManager alloc]init];
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

-(void)setInRoom:(BOOL)inRoom{
    if (inRoom != _inRoom) {
        _inRoom = inRoom;
        
        if (inRoom) self.indicatorLabel.text = @"in your room";
    }
}

//-(void)setNetworkLocation:(JGNetworkLocation)campusLocation{
//    if (campusLocation != _networkLocation) {
//        _networkLocation = campusLocation;
//
//        if (campusLocation && !self.inRoom) self.indicatorLabel.text = @"in CAMPUS_LOCATION";
//    }
//}

-(void)setOnCampus:(BOOL)onCampus{
    if (onCampus != _onCampus) {
        _onCampus = onCampus;

        if (onCampus && /*!self.networkLocation &&*/ !self.inRoom) self.indicatorLabel.text = @"on campus";
    }
}

-(void)setCity:(NSString *)city{
    if (city != _city) {
        _city = city;
        
        if (!self.onCampus && /*!self.networkLocation &&*/ !self.inRoom) self.indicatorLabel.text = [NSString stringWithFormat:@"in %@",city];
    }
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = (state == CLRegionStateInside);
    }
    else if([region.identifier isEqualToString:JGCaltechRegionIdentifier]){
        self.onCampus = (state == CLRegionStateInside);
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = YES;
    }
    else if([region.identifier isEqualToString:JGCaltechRegionIdentifier]){
        self.onCampus = YES;
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region.identifier isEqualToString:JGBedroomRegionIdentifier]) {
        self.inRoom = NO;
    }
    else if([region.identifier isEqualToString:JGBedroomRegionIdentifier]){
        self.onCampus = NO;
    }
    //else if([region.identifier isEqualToString:])
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
