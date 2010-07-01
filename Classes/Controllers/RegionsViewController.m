//
//  RegionsViewController.m
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import "RegionsViewController.h"
#import "RegionAnnotation.h"
#import "RegionCircleView.h"
#import "LocationManagerDelegate.h"

@interface RegionsViewController ()
- (void)addAnnotation:(id<MKAnnotation>)annotation; 
@end


@implementation RegionsViewController
#pragma mark -
#pragma mark Properties
@synthesize mapView;
@synthesize toolbar;
@synthesize addRegionButton;

- (void)viewDidLoad 
{
    [super viewDidLoad]; 
    
    NSSet *regions = [[LocationManagerDelegate sharedLocationManager] regions]; 
    
    // We load the regions from the Location Manager to the Map View 
    for ( CLRegion *region in regions ) {
        RegionAnnotation *regionAnnotation = [[RegionAnnotation alloc] initWithTitle:region.identifier
                                                                              radius:region.radius
                                                                          coordinate:region.center]; 
        [self addAnnotation:regionAnnotation]; 
        [regionAnnotation release]; 
    }
}

- (void)viewDidUnload 
{
	[super viewDidUnload]; 
    
    self.mapView = nil;
    self.toolbar = nil;
    self.addRegionButton = nil;
}


- (void)dealloc 
{
    self.mapView = nil;
    self.toolbar = nil;
    self.addRegionButton = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction
- (IBAction)addRegionButtonTapped
{
    NewRegionViewController *nrvc = [[NewRegionViewController alloc] initWithNibName:@"NewRegionViewController" 
                                                                              bundle:nil]; 
    nrvc.delegate = self; 
    nrvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; 
    [self presentModalViewController:nrvc animated:YES]; 
    [nrvc release]; 
}

#pragma mark -
#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)map 
didUpdateUserLocation:(MKUserLocation *)userLocation 
{
	if ( userLocation.location.horizontalAccuracy < 150 
        && userLocation.location.horizontalAccuracy > 0 ) {
		MKCoordinateRegion region;
		region.center=userLocation.location.coordinate;
		
		MKCoordinateSpan span = {0.05, 0.05};
		region.span=span;
		
		[mapView setRegion:region animated:YES];
	}
}

- (void)mapView:(MKMapView *)map didFailToLocateUserWithError:(NSError *)error
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                             message:[error localizedRecoverySuggestion]
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil]; 
    [errorAlertView show]; 
    [errorAlertView release]; 
}

- (MKAnnotationView *)mapView:(MKMapView *)map
            viewForAnnotation:(id <MKAnnotation>)annotation
{
	static NSString * const kReminderAnnotationId = @"ReminderAnnotation";
	
	MKPinAnnotationView *annotationView = nil;
	if ( [annotation isKindOfClass:[RegionAnnotation class]] )
	{
		annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:kReminderAnnotationId];
		if (annotationView == nil)
		{
			annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
                                                              reuseIdentifier:kReminderAnnotationId] autorelease];
			annotationView.canShowCallout = YES;
			annotationView.animatesDrop = YES;
			annotationView.draggable = YES;
			annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		}
	}
	return annotationView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView 
            viewForOverlay:(id<MKOverlay>)overlay 
{
	MKOverlayView *result = nil;
	if ( [overlay isKindOfClass:[RegionAnnotation class]] ) {
		result = [[[RegionCircleView alloc] initWithAnnotation:(RegionAnnotation *)overlay] autorelease];
		[(MKOverlayPathView *)result setFillColor:[[UIColor blueColor] colorWithAlphaComponent:0.2]];
		[(MKOverlayPathView *)result setStrokeColor:[[UIColor blueColor] colorWithAlphaComponent:0.7]];
		[(MKOverlayPathView *)result setLineWidth:2.0];
	} else if ([overlay isKindOfClass:[MKCircle class]]) {
		result = [[[MKCircleView alloc] initWithCircle:(MKCircle *)overlay] autorelease];
		[(MKOverlayPathView *)result setFillColor:[[UIColor purpleColor] colorWithAlphaComponent:0.3]];
	}
	return result;
}

- (void)mapView:(MKMapView *)map
 annotationView:(MKAnnotationView *)view
didChangeDragState:(MKAnnotationViewDragState)newState 
   fromOldState:(MKAnnotationViewDragState)oldState 
{
	switch (newState) {
		case MKAnnotationViewDragStateNone:
			if ( [view.annotation isKindOfClass:[RegionAnnotation class]] ) {
                [self addAnnotation:view.annotation]; 
            }
			break;
	}    
}

#pragma mark -
#pragma mark NewRegionDelegate
- (void)newRegionWithTitle:(NSString *)title 
                 andRadius:(float)radius
{
    RegionAnnotation *annotation = [[RegionAnnotation alloc] initWithTitle:title 
                                                                    radius:radius
                                                                coordinate:self.mapView.centerCoordinate];
    [self addAnnotation:annotation]; 
    [annotation release];
}

#pragma mark -
#pragma mark Privates
- (void)addAnnotation:(id<MKAnnotation>)annotation 
{
    // Indetifiers should be unique
	NSMutableArray *replaced = [NSMutableArray array];
	for (id <MKAnnotation> a in mapView.annotations) {
		if ([a isKindOfClass:[RegionAnnotation class]]) {
			if ([a.title isEqualToString:annotation.title]) {
				[replaced addObject:a];
			}
		}
	}
	
	[mapView removeAnnotations:replaced];
	[mapView removeOverlays:replaced];
	
	[mapView addAnnotation:annotation];
	if ([annotation isKindOfClass:[RegionAnnotation class]]) {
		[mapView addOverlay:(RegionAnnotation *)annotation];
	}
}

@end
