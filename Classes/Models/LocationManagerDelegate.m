//
//  LocationManager.m
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import "LocationManagerDelegate.h"
static LocationManagerDelegate *sharedInstance = nil; 
@interface LocationManagerDelegate ()
- (void)showErrorAlertView:(NSError *)error; 
@end

@implementation LocationManagerDelegate
#pragma mark -
#pragma mark Properties
@synthesize lm;

+ (void)initialize
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
}

+ (id)sharedLocationManager
{
    //Already set by +initialize.
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    //Usually already set by +initialize.
    @synchronized( self ) {
        if ( sharedInstance ) {
            //The caller expects to receive a new object, so implicitly retain it
            //to balance out the eventual release message.
            return [sharedInstance retain];
        } else {
            //When not already set, +initialize is our caller.
            //It's creating the shared instance, let this go through.
            return [super allocWithZone:zone];
        }
    }
}

- (id)init
{
    //If sharedInstance is nil, +initialize is our caller, so initialize the instance.
    //If it is not nil, simply return the instance without re-initializing it.
    if ( sharedInstance == nil ) {
        if ( (self = [super init]) ) {
            CLLocationManager *tmplm = [[CLLocationManager alloc] init]; 
            tmplm.delegate = self; 
            tmplm.desiredAccuracy = kCLLocationAccuracyKilometer; 
            tmplm.distanceFilter = 100.0; 
            self.lm = tmplm; 
            [tmplm release]; 
        }
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX; // denotes an object that cannot be released
}

- (void)release
{
    // do nothing 
}

- (id)autorelease
{
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error
{
    [self showErrorAlertView:error];
 
}

- (void)locationManager:(CLLocationManager *)manager 
         didEnterRegion:(CLRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init]; 
    NSString *notificationAlertBody = [[NSString alloc] initWithFormat:@"We are entering %@", region.identifier];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:region], 
                              @"region", nil]; 
    
    notification.alertBody = notificationAlertBody; 
    notification.userInfo = userInfo; 
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification]; 
    
    [notificationAlertBody release]; 
    [userInfo release]; 
    [notification release]; 
}

- (void)locationManager:(CLLocationManager *)manager 
          didExitRegion:(CLRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init]; 
    NSString *notificationAlertBody = [[NSString alloc] initWithFormat:@"We are leaving %@", region.identifier];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:region], 
                              @"region", nil]; 
    
    notification.alertBody = notificationAlertBody; 
    notification.userInfo = userInfo; 
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification]; 
    
    [notificationAlertBody release]; 
    [userInfo release]; 
    [notification release]; 
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    [self showErrorAlertView:error]; 
}

#pragma mark -
#pragma mark Regions
- (void)addRegion:(CLRegion *)aRegion
{
    [self.lm startMonitoringForRegion:aRegion 
                      desiredAccuracy:100.0]; 
}

- (void)removeRegion:(CLRegion *)aRegion; 
{
    [self.lm stopMonitoringForRegion:aRegion]; 
}

- (NSSet *)regions
{
    return [self.lm monitoredRegions]; 
}

#pragma mark -
#pragma mark Privates
- (void)showErrorAlertView:(NSError *)error
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                             message:[error localizedRecoverySuggestion]
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil]; 
    [errorAlertView show]; 
    [errorAlertView release];
}
@end
