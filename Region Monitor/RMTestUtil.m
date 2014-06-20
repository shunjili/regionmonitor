//
//  RMTestUtil.m
//  Region Monitor
//
//  Created by Shunji Li on 6/11/14.
//  Copyright (c) 2014 Shunji Li. All rights reserved.
//

#import "RMTestUtil.h"

@implementation RMTestUtil
+(NSSet *) regionsOfInterest
{
    // my testing locations
    NSMutableSet *regions  = [[NSMutableSet alloc] init];
//    CLCircularRegion *region1 = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(37.428243, -122.152246) radius:20 identifier:@"Block 71"];
//    [regions addObject:region1];
//    CLCircularRegion *region2 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(37.427783,  -122.152353) radius:20 identifier:@"Block 72"];
//    [regions addObject:region2];
//    CLCircularRegion *region3 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake( 37.42844750462119,  -122.15180575847626) radius:25 identifier:@"Block 70"];
//    [regions addObject:region3];
    
    // paypal testing locations
    CLCircularRegion *region4 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(   37.376906,   -121.92278299999998) radius: 62 identifier:@"Building 10"];
    [regions addObject:region4];
    
    CLCircularRegion *region5 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(   37.376855,    -121.92172600000004) radius: 25 identifier:@"Building 11"];
    [regions addObject:region5];
    CLCircularRegion *region6 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(   37.376083,     -121.92131799999999) radius:  45 identifier:@"Building 12"];
    [regions addObject:region6];
    CLCircularRegion *region7 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(    37.375891,     -121.922348) radius:  44 identifier:@"Building 13"];
    [regions addObject:region7];
    CLCircularRegion *region8 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(    37.375665,      -121.923561) radius:  61 identifier:@"Building 14"];
    [regions addObject:region8];
    
    return regions;
}
@end
