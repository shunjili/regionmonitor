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
    CLCircularRegion *region1 = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(37.428243, -122.152246) radius:20 identifier:@"Block 71"];
    [regions addObject:region1];
    CLCircularRegion *region2 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(37.427783,  -122.152353) radius:20 identifier:@"Block 72"];
    [regions addObject:region2];
    CLCircularRegion *region3 =[[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake( 37.42844750462119,  -122.15180575847626) radius:25 identifier:@"Block 70"];
    [regions addObject:region3];
    
    // paypal testing locations
    
    return regions;
}
@end
