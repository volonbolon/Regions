//
//  NewRegionViewController.h
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import <UIKit/UIKit.h>

@protocol NewRegionDelegate
@required
- (void)newRegionWithTitle:(NSString *)title andRadius:(float)radius; 
@end


@interface NewRegionViewController : UIViewController <UITextFieldDelegate> {
    UITextField *textField; 
    UIButton *addNewRegionButton; 
    id<NewRegionDelegate> delegate; 
    UILabel *sliderLabel; 
    UILabel *radiusLabel; 
    UISlider *radiusSlider; 
}

@property (retain) IBOutlet UITextField *textField;
@property (retain) IBOutlet UIButton *addNewRegionButton;
@property (assign) id<NewRegionDelegate> delegate;
@property (retain) IBOutlet UILabel *sliderLabel;
@property (retain) IBOutlet UILabel *radiusLabel;
@property (retain) IBOutlet UISlider *radiusSlider;

- (IBAction)addNewRegionButtonTapped; 
- (IBAction)radiusSliderValueChanged;

@end
