//
//  RegionCircleView.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class RegionAnnotation; 

@interface RegionCircleView : MKOverlayPathView {
    
}

@property (readonly) RegionAnnotation *regionAnnotation; 

- (id)initWithAnnotation:(RegionAnnotation *)ra; 

@end
