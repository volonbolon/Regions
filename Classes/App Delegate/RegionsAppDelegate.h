//
//  RegionsAppDelegate.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import <UIKit/UIKit.h>

@class RegionsViewController;

@interface RegionsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RegionsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RegionsViewController *viewController;

@end

