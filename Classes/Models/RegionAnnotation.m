//
//  RegionAnnotation.m
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import "RegionAnnotation.h"


@implementation RegionAnnotation
#pragma mark -
#pragma mark Properties
@synthesize title;
@synthesize coordinate;
@synthesize radius;
@synthesize region;

- (id)initWithTitle:(NSString *)newTitle 
             radius:(CLLocationDistance)newRadius
         coordinate:(CLLocationCoordinate2D)newCoordinate
{
    if ( self = [super init] ) {
        self.title = newTitle; 
        self.coordinate = newCoordinate; 
        self.radius = newRadius; 
        
        CLRegion *tmpRegion = [[CLRegion alloc] initCircularRegionWithCenter:self.coordinate
                                                                      radius:self.radius
                                                                  identifier:self.title]; 
        self.region = tmpRegion; 
        [tmpRegion release]; 
    }
    return self; 
}

- (MKMapRect)boundingMapRect 
{
	return MKMapRectWorld;
}

- (void) dealloc
{
    self.title = nil;
    self.region = nil;
    
    [super dealloc];
}

@end
