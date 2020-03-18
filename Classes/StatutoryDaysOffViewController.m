//
//  StatutoryDaysOffViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/4/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "StatutoryDaysOffViewController.h"


@implementation StatutoryDaysOffViewController



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    
	self.thisYear.text = [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.thisYearDaysOff];
	self.allYears.text = [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.otherYearsDaysOff];
	self.retirementYear.text = [NSString stringWithFormat:@"%li",self.appDelegate.settingsNew.retirementYearDaysOff];

	self.singleYearLabel.hidden = [self hideSingleYearMessage];
	
}



-(IBAction) dismissKeyboard:(id)sender {
	[self.thisYear resignFirstResponder];
	[self.allYears resignFirstResponder];
	[self.retirementYear resignFirstResponder];


}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(void) viewWillDisappear:(BOOL)animated {
	[self.thisYear resignFirstResponder];
	[self.allYears resignFirstResponder];
	[self.retirementYear resignFirstResponder];

}


- (void)textFieldDidEndEditing:(UITextField *)textField {

	if ([textField.text intValue] > 365) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There are only 365 days in a year!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];

	
	} else {
		textField.text = [NSString stringWithFormat:@"%i",[textField.text intValue]];
		if (textField.tag == 1) {
            [self.appDelegate updateSettingsInteger:[textField.text integerValue] forProperty:@"thisYearDaysOff"];
		} else if (textField.tag == 2) {
			[self.appDelegate updateSettingsInteger:[textField.text integerValue] forProperty:@"otherYearsDaysOff"];
		} else if (textField.tag == 3) {
			[self.appDelegate updateSettingsInteger:[textField.text integerValue] forProperty:@"retirementYearDaysOff"];
		}
		self.appDelegate.settingsChanged = YES;
        [self dismissViewControllerAnimated:(YES) completion:nil];
	}
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(BOOL)hideSingleYearMessage
{

    if ([GlobalMethods currentYear] == self.appDelegate.settingsNew.retirementYear)
    {
    	return NO;
    }
    return YES;


}

@end
