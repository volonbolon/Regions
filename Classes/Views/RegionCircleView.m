//
//  RegionCircleView.m
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import "RegionCircleView.h"
#import "RegionAnnotation.h"

@implementation RegionCircleView
- (id)initWithAnnotation:(RegionAnnotation *)ra
{
    if ( self = [super initWithOverlay:ra] ) {
        [self.regionAnnotation addObserver:self
                                forKeyPath:@"coordinate"
                                   options:0 
                                   context:nil];
        [self.regionAnnotation addObserver:self
                                forKeyPath:@"radius"
                                   options:0 
                                   context:nil];
    }
    return self; 
}

- (RegionAnnotation *)regionAnnotation 
{
    return (RegionAnnotation *)self.overlay; 
}

- (void)dealloc 
{
	[self.regionAnnotation removeObserver:self
                               forKeyPath:@"coordinate"];
	[self.regionAnnotation removeObserver:self 
                               forKeyPath:@"radius"];
    
	[super dealloc];
}

- (void)createPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CLLocationCoordinate2D center = self.regionAnnotation.coordinate;
    CGPoint centerPoint = [self pointForMapPoint:MKMapPointForCoordinate(center)];
    CGFloat radius = MKMapPointsPerMeterAtLatitude(center.latitude) * self.regionAnnotation.radius;
    CGPathAddArc(path, NULL, centerPoint.x, centerPoint.y, radius, 0, 2 * M_PI, true);
    
    self.path = path;
    CGPathRelease(path);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
	[self invalidatePath];
}
@end
