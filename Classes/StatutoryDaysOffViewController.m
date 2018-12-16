//
//  StatutoryDaysOffViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/4/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "StatutoryDaysOffViewController.h"


@implementation StatutoryDaysOffViewController

@synthesize thisYear;
@synthesize allYears;
@synthesize retirementYear;
@synthesize singleYearLabel;

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
	self.thisYear.text = [self.appDelegate.settings objectForKey:@"ThisYearDaysOff"];
	self.allYears.text = [self.appDelegate.settings objectForKey:@"AllYearsDaysOff"];
	self.retirementYear.text = [self.appDelegate.settings objectForKey:@"RetirementYearDaysOff"];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

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
		[alertView release];
	
	} else {
		textField.text = [NSString stringWithFormat:@"%i",[textField.text intValue]];
		if (textField.tag == 1) {
			[self.appDelegate.settings  setObject:textField.text forKey:@"ThisYearDaysOff"];
		} else if (textField.tag == 2) {
			[self.appDelegate.settings  setObject:textField.text forKey:@"AllYearsDaysOff"];
		} else if (textField.tag == 3) {
			[self.appDelegate.settings  setObject:textField.text forKey:@"RetirementYearDaysOff"];
		}
		self.appDelegate.newdata = YES;
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[thisYear release];
	[allYears release];
	[retirementYear release];
    [singleYearLabel release];
    [super dealloc];
}


-(BOOL)hideSingleYearMessage
{
	// get todays comps
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit; 
	NSDateComponents *todayComps = [gregorian components:unitFlags fromDate:today];
	int todayYear = [todayComps year];

	// get retirement comps
	NSCalendar *gregorian2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags2 = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit; 
	NSDateComponents *rComps = [gregorian2 components:unitFlags2 fromDate:[self.appDelegate.settings objectForKey:@"RetirementDate"]];
	int retireYear = [rComps year];
    
	[gregorian2 release];
    
    if (todayYear == retireYear)
    {
    	return NO;
    }
    return YES;


}

@end
