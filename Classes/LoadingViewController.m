    //
//  LoadingViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/16/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "LoadingViewController.h"


@implementation LoadingViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *settingsBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.rightBarButtonItem = settingsBarItem;
	[settingsBarItem release];
	self.navigationItem.rightBarButtonItem.enabled = NO;
	
	UIBarButtonItem *gotoBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
	self.navigationItem.leftBarButtonItem = gotoBarItem;
	[gotoBarItem release];
	self.navigationItem.leftBarButtonItem.enabled = NO;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	

	UIView *navTitleView	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	navTitleView.backgroundColor = [UIColor clearColor]; 
	
	UILabel *navTitleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 320, 28)];
	navTitleLabel1.text = @"Retirement Countdown";
	navTitleLabel1.backgroundColor = [UIColor clearColor]; 
	navTitleLabel1.textColor = [UIColor whiteColor]; 
	navTitleLabel1.font = [UIFont boldSystemFontOfSize:16];
	navTitleLabel1.textAlignment = UITextAlignmentCenter;
	
	UILabel *navTitleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 320, 16)];
	navTitleLabel2.text = @"         ";  
	navTitleLabel2.backgroundColor = [UIColor clearColor]; 
	navTitleLabel2.textColor = [UIColor whiteColor]; 
	navTitleLabel2.font = [UIFont systemFontOfSize:14];
	navTitleLabel2.textAlignment = UITextAlignmentCenter;	
	
	[navTitleView addSubview:navTitleLabel1];
	[navTitleView addSubview:navTitleLabel2];
	[navTitleLabel1 release];
	[navTitleLabel2 release];
	[self.navigationController.navigationBar addSubview:navTitleView];
	[navTitleView release];

	
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
    [super dealloc];
}


@end
