    //
//  BaseViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/10/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
@synthesize appDelegate;


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
	self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    
    	// iOS7 items
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
	if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)])
    {
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
	if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}



// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}



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
	[appDelegate release];
    [super dealloc];
}


@end
