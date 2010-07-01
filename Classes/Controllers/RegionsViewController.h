//
//  RegionsViewController.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NewRegionViewController.h"

@interface RegionsViewController : UIViewController <NewRegionDelegate> {
    MKMapView *mapView; 
    UIToolbar *toolbar; 
    UIBarButtonItem *addRegionButton; 
}

@property (retain) IBOutlet MKMapView *mapView;
@property (retain) IBOutlet UIToolbar *toolbar;
@property (retain) IBOutlet UIBarButtonItem *addRegionButton;

- (IBAction)addRegionButtonTapped; 

@end

