//
//  RegionAnnotation.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RegionAnnotation : NSObject <MKOverlay> {
    NSString *title; 
    CLLocationCoordinate2D coordinate; 
    CLLocationDistance radius; 
    CLRegion *region; 
}

@property (retain) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (assign) CLLocationDistance radius;
@property (retain) CLRegion *region;

- (id)initWithTitle:(NSString *)newTitle 
             radius:(CLLocationDistance)newRadius
         coordinate:(CLLocationCoordinate2D)newCoordinate; 

@end
