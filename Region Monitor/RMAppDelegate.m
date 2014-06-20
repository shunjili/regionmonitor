//
//  RMAppDelegate.m
//  Region Monitor
//
//  Created by Shunji Li on 6/11/14.
//  Copyright (c) 2014 Shunji Li. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMTestUtil.h"

@interface RMAppDelegate()<CLLocationManagerDelegate>
@property (nonatomic, strong) NSSet *regionsOfInterest;
@end

@implementation RMAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    return YES;
}
#pragma mark-  Location manager delegate Method

//- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
//{
//    if (self.latestRegion == region) {
//        self.latestRegion = nil;
//    }
//    NSLog(@"exited a region");
//}
//
//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
//{
//    if ([region isKindOfClass:[CLCircularRegion class]])
//    {
//        CLCircularRegion *circular = (CLCircularRegion *) region;
//        CLLocation *location =self.locationManager.location;
//
//        if ([circular containsCoordinate:location.coordinate])
//        {
//            self.latestRegion = region;
//        }
//        
//    }
//}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
// This method is not useful for the task we are doing because it cannot achieve the desired accuracy.
//    if ([region isKindOfClass:[CLCircularRegion class]]) {
//        CLCircularRegion *circular = (CLCircularRegion *) region;
//
//        CLLocation *location =self.locationManager.location;
//        NSDictionary *info = @{@"location":location};
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationChanged" object:self userInfo:info];
//        
//        if ([circular containsCoordinate:location.coordinate])
//        {
//            self.latestRegion = region;
//        }
//        NSLog(@"You are in region %@ : %@", circular.identifier, [circular containsCoordinate:location.coordinate]? @"YES":@"NO" );
//    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location =self.locationManager.location;
    CLRegion *previousRegion = self.latestRegion.copy;
    self.latestRegion = nil;
    for (CLRegion *region  in self.regionsOfInterest) {
        if ([region isKindOfClass:[CLCircularRegion class]]) {
            CLCircularRegion *cRegion = (CLCircularRegion *) region;
            if ([cRegion containsCoordinate:location.coordinate])
            {
                if (!previousRegion|| ![previousRegion.identifier isEqualToString:cRegion.identifier])
                    {
                    NSDictionary *info = @{@"location":location, @"region":cRegion};
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationChanged" object:self userInfo:info];
                    self.latestRegion = cRegion;
                    return;
                    }
                else if (!self.latestRegion) {
                    self.latestRegion = cRegion;
                }
            }
        }
    }
    if (!self.latestRegion) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"outOfRange" object:nil userInfo:nil];
    }
    
   
}

#pragma mark- Application Life Cycle

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- Accessors
- (NSSet *) regionsOfInterest
{
    if (! _regionsOfInterest) {
        _regionsOfInterest = [RMTestUtil regionsOfInterest];
    }
    return _regionsOfInterest;
}

@end
