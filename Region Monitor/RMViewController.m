//
//  RMViewController.m
//  Region Monitor
//
//  Created by Shunji Li on 6/11/14.
//  Copyright (c) 2014 Shunji Li. All rights reserved.
//

#import "RMViewController.h"
#import <MapKit/MapKit.h>
#import "RMAppDelegate.h"
#import "RMTestUtil.h"

@interface RMViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIButton *showCurrentLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *showPaypalCampusButton;
@property (weak, nonatomic) RMAppDelegate *appDelegate;
@end

@implementation RMViewController

- (void)viewDidLoad
{
    [self setupNotification];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSSet *regions = [RMTestUtil regionsOfInterest];
    CLLocation *currentLocation = self.appDelegate.locationManager.location;
    for (CLCircularRegion *region in regions) {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
        [self.mapView addOverlay:circle];
        if ([region containsCoordinate:currentLocation.coordinate]) {
            [self setTitleTextForLatestRegion:region];
        }
    }
    [self setMapViewRegionForLocation:currentLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RMAppDelegate *) appDelegate
{
    RMAppDelegate *delegate = (RMAppDelegate *) [[UIApplication sharedApplication] delegate];
    return  delegate;
}

- (CLLocationManager *) locationManager
{
    RMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return delegate.locationManager;
}

- (void) setMapViewRegionForLocation: (CLLocation*) location
{
    MKCoordinateRegion  region = MKCoordinateRegionMakeWithDistance(location.coordinate, 100, 100);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    [self.mapView setShowsUserLocation:YES];
}

- (void) setupNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:@"locationChanged" object:nil queue:nil usingBlock:^(NSNotification *note) {
        CLLocation *location = note.userInfo[@"location"];
        CLCircularRegion *region = note.userInfo[@"region"];
        [self setMapViewRegionForLocation:location];
        //NSLog(@"latest region %@", self.appDelegate.latestRegion);
        [self setTitleTextForLatestRegion: region];

    }];
    [center addObserverForName:@"outOfRange" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self setTitleTextForLatestRegion:nil];
    }];
}

- (void) setTitleTextForLatestRegion:(CLRegion *) region
{
    if (region) {
        [self.titleLabel setText:[NSString stringWithFormat:@"Welcome to  %@", region.identifier]];
    }else{
        [self.titleLabel setText:@"Sorry, you are not on campus"];
    }
}

#pragma mark- Mapview delegate methods

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircle *circle = (MKCircle *) overlay;
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle: circle];
            circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
        return circleView;}
    return nil;
    
}

#pragma mark- IBActions 
- (IBAction)showCurrentLocation:(id)sender
{
    CLLocation *location = self.appDelegate.locationManager.location;
    [self setMapViewRegionForLocation:location];
}
- (IBAction)showPaypalCampus:(id)sender
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude: 37.376906 longitude:-121.922783];
    [self setMapViewRegionForLocation:location];
}

   
@end
