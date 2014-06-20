//
//  RMAppDelegate.h
//  Region Monitor
//
//  Created by Shunji Li on 6/11/14.
//  Copyright (c) 2014 Shunji Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface RMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLRegion *latestRegion;
@end
