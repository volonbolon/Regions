//
//  LocationManager.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManagerDelegate : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *lm; 
}

+ (id)sharedLocationManager;

@property (retain, readonly) NSSet *regions;
@property (retain) CLLocationManager *lm;

#pragma mark -
#pragma mark Regions
- (void)addRegion:(CLRegion *)aRegion;
- (void)removeRegion:(CLRegion *)aRegion;
- (NSSet *)regions; 
@end
