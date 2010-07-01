//
//  NewRegionViewController.m
//  Regions
//
//  Created by Ariel Rodriguez
//  volonbolon@gmail.com
//

#import "NewRegionViewController.h"


@implementation NewRegionViewController
#pragma mark -
#pragma mark Properties
@synthesize textField;
@synthesize addNewRegionButton;
@synthesize delegate;
@synthesize sliderLabel;
@synthesize radiusLabel;
@synthesize radiusSlider;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    
    self.textField = nil;
    self.addNewRegionButton = nil;
    self.sliderLabel = nil;
    self.radiusLabel = nil;
    self.radiusSlider = nil;
}

- (void)dealloc 
{
    self.textField = nil;
    self.addNewRegionButton = nil;
    self.sliderLabel = nil;
    self.radiusLabel = nil;
    self.radiusSlider = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction
- (IBAction)addNewRegionButtonTapped
{
    [self.delegate newRegionWithTitle:self.textField.text andRadius:self.radiusSlider.value]; 
    [self.parentViewController dismissModalViewControllerAnimated:YES]; 
}

- (IBAction)radiusSliderValueChanged
{
    float value = self.radiusSlider.value; 
    NSString *valueAsString = [[NSString alloc] initWithFormat:@"%d", (int)value]; 
    self.radiusLabel.text = valueAsString; 
    [valueAsString release]; 
    valueAsString = nil; 
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder]; 
    return YES; 
}

@end
