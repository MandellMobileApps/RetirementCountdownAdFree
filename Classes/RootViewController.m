//
//  RootViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/14/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorsClass.h"
#import "RCSettingsViewController.h"
#import "WorkdaysViewController.h"
#import "TimeRemaining.h"
#import "LoadingViewController.h"
#import <AudioToolbox/AudioToolbox.h>





@implementation RootViewController

@synthesize calendarcurrent;
@synthesize otherLabels, totalsecondsleft, secondsleft, minutesleft, hoursleft, daysleft, retirementDate, settings, transitioning;
@synthesize startTouchPosition, overallView, containerview, calendarview, calendarnavview, calendardaysview, pictureview, swipeview;
@synthesize displayoption, timer, tapCount;
@synthesize prevYearButton, prevMonthButton, nextMonthButton, nextYearButton;
@synthesize navbarView;
@synthesize bannerIsVisible;
@synthesize bannerView;
@synthesize yearLabel;
@synthesize monthLabel; 
@synthesize dayLabel;
@synthesize workDaysLabel;
@synthesize hoursLabel;
@synthesize minutesLabel;
@synthesize secondsLabel;
@synthesize notWorkingLabel;
@synthesize monthNameLabel;
@synthesize calendarLabel;
@synthesize calendarDaysLabels;
@synthesize workLabel;
@synthesize workLeftLabels;

@synthesize updateTimer;

- (void)dealloc {
	
	[calendarcurrent release];
	[otherLabels release];
    [monthNameLabel release];
	[yearLabel release];
	[monthLabel release]; 
	[dayLabel release];
	[workDaysLabel release];
	[hoursLabel release];
	[minutesLabel release];
	[secondsLabel release];
	[notWorkingLabel release];
	[prevYearButton release];
	[prevMonthButton release];
	[nextMonthButton release];
	[nextYearButton release];
	[overallView release];
	[containerview release];
	[calendarview release];
	[calendarnavview release];
	[calendardaysview release];
	[swipeview release];
	[pictureview release];
	[retirementDate release];
	[settings release];
	[displayoption release];
	[timer release];
	[navbarView release];
	if (bannerView) {
        bannerView.delegate = nil;
        [bannerView release];
    }
	[calendarLabel release];
	[calendarDaysLabels release];
	[workLabel release];
	[workLeftLabels release];
	[updateTimer release];
	[super dealloc];
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
//	if ([[self.appDelegate.settings objectForKey:@"FirstTimeLoad"] isEqualToString:@"YES"]) {
//			NSString *actionSheetTitle = [[NSString alloc ] initWithString: @"        Welcome to Retirement Countdown!\n\n   	             Tap the Settings button to set your Retirement Date."];
//			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Don't Remind Me", nil];
//			actionSheet.tag = 2;
//            [actionSheet showInView:self.view];
//			[actionSheetTitle release];
//			[actionSheet release];
//	}
		
	self.bannerIsVisible = NO;
    
#ifdef LITE_VERSION
	[self createBannerView];
#endif

	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[self.appDelegate imageFromCache:[self.appDelegate.settings objectForKey:@"PictureName"]]];
	tempImageView.frame = CGRectMake(0, 0, 320, 300);
	tempImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.pictureview = tempImageView;
	[tempImageView release]; 
	
	UIBarButtonItem *settingsBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showSettingsView:)];
	self.navigationItem.rightBarButtonItem = settingsBarItem;
	[settingsBarItem release];
	
	UIBarButtonItem *gotoBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showGotoView)];
	self.navigationItem.leftBarButtonItem = gotoBarItem;
	[gotoBarItem release];
	
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];
	
	self.appDelegate.colorsChanged = YES;
	if ([[self.appDelegate.settings objectForKey:@"CurrentDisplay"] isEqualToString:@"Picture"]) {
	[self fliptoPictureWithAnimation:NO];
	}

	Calendar *calendarcurrentTemp = [[Calendar alloc] initWithHandler:self];
	self.calendarcurrent = calendarcurrentTemp;
	[calendarcurrentTemp release];
	[self.calendardaysview addSubview:self.calendarcurrent];
    

}

-(void)updateNavigationBarTitle {
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	NSString *retirementDateString = [dateFormatter stringFromDate:[self.appDelegate.settings objectForKey:@"RetirementDate"]];
	UIView *navTitleView	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	navTitleView.backgroundColor = [UIColor clearColor]; 
	self.navbarView = navTitleView;
	
	UILabel *navTitleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 320, 28)];
	navTitleLabel1.text = @"Retirement Countdown";
	navTitleLabel1.backgroundColor = [UIColor clearColor]; 
	navTitleLabel1.textColor = [UIColor whiteColor]; 
	navTitleLabel1.font = [UIFont boldSystemFontOfSize:16];
	navTitleLabel1.textAlignment = UITextAlignmentCenter;

#ifdef LITE_VERSION    
	UIImageView *liteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(227,0, 44, 44)];
	liteImageView.backgroundColor = [UIColor clearColor];
    liteImageView.image = [UIImage imageNamed:@"Lite.png"];
    [navTitleView addSubview:liteImageView];
    [liteImageView release];
#else

#endif


	UILabel *navTitleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 320, 16)];
	navTitleLabel2.text = [NSString stringWithFormat:@"to  %@",retirementDateString];  
	navTitleLabel2.backgroundColor = [UIColor clearColor]; 
	navTitleLabel2.textColor = [UIColor whiteColor]; 
	navTitleLabel2.font = [UIFont systemFontOfSize:14];
	navTitleLabel2.textAlignment = UITextAlignmentCenter;	
	
	[navTitleView addSubview:navTitleLabel1];
	[navTitleView addSubview:navTitleLabel2];
	[navTitleLabel1 release];
	[navTitleLabel2 release];
	[self.navigationController.navigationBar addSubview:self.navbarView];
	[navTitleView release];
	[dateFormatter release];
	
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	if(self.appDelegate.colorsChanged == YES) {	
		UIColor *defaultBackgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
		self.view.backgroundColor = defaultBackgroundColor;
		self.overallView.backgroundColor = defaultBackgroundColor;
		self.calendardaysview.backgroundColor =  defaultBackgroundColor; 
		self.calendarnavview.backgroundColor =  defaultBackgroundColor;   
		self.calendarview.backgroundColor =	defaultBackgroundColor; 
		self.containerview.backgroundColor =	defaultBackgroundColor;
		self.prevYearButton.backgroundColor = defaultBackgroundColor;
		self.prevMonthButton.backgroundColor = defaultBackgroundColor;
		self.nextMonthButton.backgroundColor = defaultBackgroundColor;
		self.nextYearButton.backgroundColor = defaultBackgroundColor;
		self.monthNameLabel.backgroundColor = defaultBackgroundColor;
		self.pictureview.backgroundColor = defaultBackgroundColor;
		
		[self.calendarcurrent reloadWeekdayNameLabels];
		
		UIColor *defaultTextColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:7])];
		self.monthNameLabel.textColor = defaultTextColor;
		self.otherLabels.textColor = defaultTextColor;
        self.calendarLabel.textColor = defaultTextColor;
        self.calendarDaysLabels.textColor = defaultTextColor;
        self.workLabel.textColor = defaultTextColor;
        self.workLeftLabels.textColor = defaultTextColor;

		NSInteger viewheight = [self getviewheight];
		CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
		[self.calendardaysview setFrame:calendardaysframe];
		self.appDelegate.colorsChanged = NO;
	}
	
	if (self.appDelegate.pictureChanged == YES) {

		UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[self.appDelegate imageFromCache:[self.appDelegate.settings objectForKey:@"PictureName"]]];
		tempImageView.frame = CGRectMake(0, 0, 320, 300);
		tempImageView.contentMode = UIViewContentModeScaleAspectFit;
		self.pictureview = tempImageView;
		[tempImageView release]; 
		self.appDelegate.pictureChanged = NO;
		[self fliptoPictureWithAnimation:YES];
	}

	
	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li", [self.calendarcurrent currentMonthName],(long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;
	[monthyearlabeltemp release];
	[self updatelabelsWithReset:YES];
	
	[self.calendarcurrent drawCalendarToCurrentMonth];
	[self performSelector:@selector(capturescreen) withObject:nil afterDelay:1.0];
	
	self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateCalendarAndLabels:) userInfo:nil repeats:YES];

	

}

-(void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:NO];
	[self updateNavigationBarTitle];

}

-(void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:NO];
	[self.navbarView removeFromSuperview];
	[self.updateTimer invalidate];
}


-(void) updateCalendarAndLabels:(NSTimer*)theTimer {
	[self.calendarcurrent drawCalendarToCurrentMonth];
	[self updatelabelsWithReset:NO];
}

-(NSData*)capturescreen {
	UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()]; 
	UIImage *screencapture = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext(); 
	NSData *imageinpng = UIImagePNGRepresentation(screencapture);
	NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"lastScreenCapture"];
	[imageinpng writeToFile:pathName atomically:YES];
	NSData *returnData = [[[NSData alloc] initWithData:imageinpng] autorelease];
	return returnData;
}



-(void)sendEmail {
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	if ((mailClass != nil) && ([mailClass canSendMail])){
		MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
		mailcontroller.mailComposeDelegate = self;
		[mailcontroller addAttachmentData:[self capturescreen] mimeType:@"image/png" fileName:@"Retirement Countdown"];
		[self presentModalViewController:mailcontroller animated:YES];
		[mailcontroller release];
		
	}else{
		//Alert that cannot send mail on this device OS version;
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Cannot send mail on this Device or iOS version" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			break;
		default:
			//message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


-(void)flipView {
	if ([self.pictureview superview]) {	
//	NSLog(@"flipping to Calendar");
		[self fliptoCalendarWithAnimation:YES];
		
	} else {
//	NSLog(@"flipping to Picture");
		[self fliptoPictureWithAnimation:YES];
		
	}
}

-(void) fliptoCalendarWithAnimation:(BOOL)animated {
	if (animated == YES){
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationTransition:(UIViewAnimationTransitionFlipFromLeft) forView:self.containerview cache:YES];
		[self.pictureview removeFromSuperview];
		[self.containerview addSubview:self.calendarview];
		[UIView commitAnimations];
	} else {
		[self.pictureview removeFromSuperview];
		[self.containerview addSubview:self.calendarview];
	}
	[self.appDelegate.settings setObject:@"Calendar" forKey:@"CurrentDisplay"];
//	NSLog(@"Current Display Settings: %@",[self.appDelegate.settings objectForKey:@"CurrentDisplay"]);

}

-(void) fliptoPictureWithAnimation:(BOOL)animated {
	if (animated == YES) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationTransition:(UIViewAnimationTransitionFlipFromLeft) forView:self.containerview cache:YES];
		[self.calendarview removeFromSuperview];
		for (id item in self.containerview.subviews) {
			if ([item isKindOfClass:[UIImageView class]]) {
				[item removeFromSuperview];
			}
		}
		[self.containerview addSubview:self.pictureview];
		[self.containerview bringSubviewToFront:self.pictureview];
		[UIView commitAnimations];
	} else  {
		[self.calendarview removeFromSuperview];
		for (id item in self.containerview.subviews) {
			if ([item isKindOfClass:[UIImageView class]]) {
				[item removeFromSuperview];
			}
		}
		[self.containerview addSubview:self.pictureview];
		[self.containerview bringSubviewToFront:self.pictureview];
	}
	[self.appDelegate.settings setObject:@"Picture" forKey:@"CurrentDisplay"];
}




-(IBAction)showSettingsView:(id)sender {
	RCSettingsViewController *rcsettingsViewController = [[RCSettingsViewController alloc] initWithNibName:@"RCSettings" bundle:nil];
	rcsettingsViewController.title = @"Settings";
	[[self navigationController] pushViewController:rcsettingsViewController animated:YES];
	[rcsettingsViewController release];

}


-(void)updatelabelsWithReset:(bool)reset {

	if (reset) {
		self.yearLabel.text = @"";
		self.monthLabel.text = @""; 
		self.dayLabel.text = @"";
		self.workDaysLabel.text = @"";
		self.hoursLabel.text = @"";
		self.minutesLabel.text = @"";
		self.secondsLabel.text = @"";
	}
	TimeRemaining *myTimeRemaining = [[TimeRemaining alloc] init];
	self.displayoption = [self.appDelegate.settings objectForKey:@"DisplayOption"];
	
	if ([self.timer isValid] == YES){
		[self.timer invalidate];
	}	
	


    NSArray *dayAndSecondsLeft = [myTimeRemaining getTimeRemainingFor:[self.appDelegate.settings objectForKey:@"RetirementDate"]];
    self.daysleft = [[dayAndSecondsLeft objectAtIndex:0]intValue];
    self.totalsecondsleft = [[dayAndSecondsLeft objectAtIndex:1]intValue];

    NSNumber* daysLeftNumber = [NSNumber numberWithInt:self.daysleft];
    NSString* daysLeftString = [NSNumberFormatter localizedStringFromNumber:daysLeftNumber numberStyle:kCFNumberFormatterDecimalStyle];
	self.workDaysLabel.text = daysLeftString;
    self.hoursLabel.text = @"0";
    self.minutesLabel.text = @"0";
    self.secondsLabel.text = @"0";
    
    if (self.totalsecondsleft > 0) {
        [self starttimer];
		self.notWorkingLabel.hidden = YES;
    }
    else
    {
    	self.notWorkingLabel.hidden = NO;
    }

    NSDateComponents *abscomps= [myTimeRemaining getAbsoluteTimeRemaining:[self.appDelegate.settings objectForKey:@"RetirementDate"]];
    int years = [abscomps year];
    int months = [abscomps month];
    int days = [abscomps day];
    self.yearLabel.text = [NSString stringWithFormat:@"%i",years];
    self.monthLabel.text = [NSString stringWithFormat:@"%i",months];
    self.dayLabel.text = [NSString stringWithFormat:@"%i",days];
	[myTimeRemaining release];
	
}

-(void)starttimer {
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMode) userInfo:nil repeats:YES];
	
}

-(void)timerMode {
	
	self.secondsleft = self.totalsecondsleft % 60;
	self.minutesleft = self.totalsecondsleft / 60;
	self.hoursleft = self.minutesleft / 60;
	self.minutesleft = self.minutesleft % 60;
	
	if (self.totalsecondsleft == 1) {
		[self.timer invalidate];
		self.timer = nil; 
	}
	self.totalsecondsleft--;
    NSNumber* daysLeftNumber = [NSNumber numberWithInt:self.daysleft];
    NSString* daysLeftString = [NSNumberFormatter localizedStringFromNumber:daysLeftNumber numberStyle:kCFNumberFormatterDecimalStyle];
	self.workDaysLabel.text = daysLeftString;
    self.hoursLabel.text = [NSString stringWithFormat:@"%i",self.hoursleft];
    self.minutesLabel.text = [NSString stringWithFormat:@"%i",self.minutesleft];
    self.secondsLabel.text = [NSString stringWithFormat:@"%i",self.secondsleft];
}

-(NSInteger)getviewheight {
	NSInteger totalweeks = self.calendarcurrent.totalweeks;
	int height = 0;
	if(totalweeks == 4) {
		height = kCalendarDaysHeight4;
	}	
	if(totalweeks == 5) {
		height = kCalendarDaysHeight5;
	}	
	if(totalweeks == 6) {
		height = kCalendarDaysHeight6;
	}
	return height;
}


-(void)GotoToday {
	NSString *currentdisplay = [self.appDelegate.settings objectForKey:@"CurrentDisplay"];
	if ([currentdisplay isEqualToString:@"Picture"]) { 
		[self fliptoCalendarWithAnimation:YES];
	}
	[self performTransition:3];
	[self.calendarcurrent gotoToday];
	NSInteger viewheight = [self getviewheight];
	CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
	[self.calendardaysview setFrame:calendardaysframe];
	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;
	[monthyearlabeltemp release];
	[self updatelabelsWithReset:YES];
}


-(void)GotoRetirementDay {
	NSString *currentdisplay = [self.appDelegate.settings objectForKey:@"CurrentDisplay"];
	if ([currentdisplay isEqualToString:@"Picture"]) { 
		[self fliptoCalendarWithAnimation:YES];
	}
	[self performTransition:3];
	[self.calendarcurrent gotoRetirementDay];
	NSInteger viewheight = [self getviewheight];
	CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
	[self.calendardaysview setFrame:calendardaysframe];
	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;
	[monthyearlabeltemp release];
	[self updatelabelsWithReset:YES];
}


- (IBAction)prevMonth:(id)sender { 
	if(!self.transitioning)
	{
		[self performTransition:1];
		[self.calendarcurrent previousMonth];
		NSInteger viewheight = [self getviewheight];
		CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
		[self.calendardaysview setFrame:calendardaysframe];
		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;
		[monthyearlabeltemp release];
		[self updatelabelsWithReset:YES];
	}
	
}

- (IBAction)nextMonth:(id)sender { 
	if(!self.transitioning)
	{
		[self performTransition:2];
		[self.calendarcurrent nextMonth];
		NSInteger viewheight = [self getviewheight];
		CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
		[self.calendardaysview setFrame:calendardaysframe];
		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;
		[monthyearlabeltemp release];
		[self updatelabelsWithReset:YES];
	}
}


- (IBAction)prevYear:(id)sender {
	if(!self.transitioning)
	{
		[self performTransition:1];
		[self.calendarcurrent previousYear];
		NSInteger viewheight = [self getviewheight];
		CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
		[self.calendardaysview setFrame:calendardaysframe];
		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;
		[monthyearlabeltemp release];
		[self updatelabelsWithReset:YES];
	}
}

- (IBAction)nextYear:(id)sender { 
	[self performTransition:2];
	[self.calendarcurrent nextYear];
	NSInteger viewheight = [self getviewheight];
	CGRect calendardaysframe = CGRectMake(kCalendarDaysleft,kCalendarDaystop,kCalendarwidth,viewheight);
	[self.calendardaysview setFrame:calendardaysframe];
	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;
	[monthyearlabeltemp release];
	[self updatelabelsWithReset:YES];
}


-(void)performTransition:(NSInteger)direction
{
	// Create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	transition.duration = 0.35;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush; 
	switch (direction) {
		case 1:
			transition.subtype = kCATransitionFromLeft;
			break;
		case 2:
			transition.subtype = kCATransitionFromRight;
			break;
		case 3:
			transition.subtype = kCATransitionFromBottom;
			break;
		case 4:
			transition.subtype = kCATransitionFromTop;
			break;
		default:
			break;
	}
	self.transitioning = YES;
	transition.delegate = self;
	[self.calendardaysview.layer addAnimation:transition forKey:nil];
	
}

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	self.transitioning = NO;
}

- (void)daySelectedDoubleTap:(id)sender {
	[self.calendarcurrent updateSelectionDoubleTap:sender];
	[self updatelabelsWithReset:YES];

}

- (void)daySelectedSingleTap:(id)sender { 
	[self.calendarcurrent updateSelection:sender];
	[self updatelabelsWithReset:YES];

}

-(void)resetTapCount:(id)sender {
//	if (self.tapCount == 1) {
//		[self daySelectedSingleTap:(id)sender];
//	} 
	self.tapCount = 0;
	
}


- (void)dayButtonTapped:(UIButton*)sender { 

	if (sender.tag > 0) {
		NSString *path = [GlobalMethods dataFilePathofBundle:@"click1.wav"];
		
		//declare a system sound id
		SystemSoundID soundID;
		
		//Get a URL for the sound file
		NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
		
		//Use audio sevices to create the sound
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
		
		//Use audio services to play the sound
		AudioServicesPlaySystemSound(soundID);


        self.tapCount = self.tapCount + 1; 
        //NSLog(@"[sender tag]  %i",[sender tag]);
        switch (self.tapCount) {
            case 1:
                [self daySelectedSingleTap:(id)sender];
                [self performSelector:@selector(resetTapCount:) withObject:(id)sender afterDelay:0.7];
                break;
            case 2:
                self.tapCount = 0;
                [self daySelectedDoubleTap:(id)sender];
                break;
            default:
                break;
        }
    }
}



-(void) showGotoView {
	NSString *pictureStatus;
	if ([[self.appDelegate.settings objectForKey:@"CurrentDisplay"] isEqualToString:@"Calendar"]) {
		pictureStatus = @"Display Picture";
	} else {
		pictureStatus = @"Display Calendar";
	}
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@" " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Go To Today",@"Go To Retirement Date",pictureStatus, @"Send Email",nil];
	actionSheet.tag = 1;
	[actionSheet showInView:self.containerview];
	[actionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//NSLog(@"actionSheet.tag %i",actionSheet.tag);
//NSLog(@"buttonIndex  %i",buttonIndex);

	if (actionSheet.tag == 1) {
		if(buttonIndex == 0) {
			[self GotoToday];
		} else if (buttonIndex == 1) {
			[self GotoRetirementDay];
		} else if (buttonIndex == 2) {
			[self flipView];
		} else if (buttonIndex == 3) {
			[self sendEmail];
		}
	} else if (actionSheet.tag == 2) {
		if(buttonIndex == 0) {
			[self.appDelegate.settings setObject:@"NO" forKey:@"FirstTimeLoad"];
			[self.appDelegate saveAllData];
		}
	}
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
	if (actionSheet.tag == 2) {
		UIImageView *settingsButton  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SettingsButton.png"]];
		settingsButton.frame = CGRectMake(20, 50, 49, 34);
		[actionSheet addSubview:settingsButton];
		[settingsButton release];
	}
	
}


/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
	 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 

#pragma mark ADBannerViewDelegate methods

//-(void) loadAd {
//	Class classAdBannerView = NSClassFromString(@"ADBannerView");
//	if (classAdBannerView) {
//		ADBannerView *tempAdView = [[classAdBannerView alloc] initWithFrame:CGRectZero];
//		
//		
//		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.2) {
//			tempAdView.currentContentSizeIdentifier =  ADBannerContentSizeIdentifierPortrait;
//		} else {
//			tempAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
//		}
//		tempAdView.delegate = self;
//		
//		// Set initial frame to be offscreen
//		tempAdView.frame = CGRectMake(0, -50, 320, 50);
//		
//		// add adView to View
//		self.adView = tempAdView;
//		[self.view addSubview:self.adView];
//		[tempAdView release];
//	}
//	
//}


- (void)createBannerView {
	
	
	
    Class cls = NSClassFromString(@"ADBannerView");
    if (cls) {
		NSLog(@"cls");
        NSString *MycontentSizeIdentifierPortrait = ADBannerContentSizeIdentifierPortrait;

        ADBannerView *adView = [[cls alloc] initWithFrame:CGRectZero];
        adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:MycontentSizeIdentifierPortrait,nil];
		
        // Set the current size based on device orientation
        adView.currentContentSizeIdentifier = MycontentSizeIdentifierPortrait;
        adView.delegate = self;

		
        // Set intital frame to be offscreen
        CGRect bannerFrame = adView.frame;
        bannerFrame.origin.y = -bannerFrame.size.height;
        adView.frame = bannerFrame;

        self.bannerView = adView;
        [self.view addSubview:self.bannerView];
		[self.view bringSubviewToFront:self.bannerView];
        [adView release];

    }
	
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
NSLog(@"bannerViewDidLoadAd");
	if (!self.bannerIsVisible) {
		[UIView beginAnimations:@"animateAdBannerOn" context:NULL];
		// banner is invisible now and moved out of the screen on 50 px
		banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
		self.overallView.frame = CGRectOffset(self.overallView.frame, 0, 50);
//		self.timeRemainingText.frame = CGRectOffset(self.timeRemainingText.frame, 0, -50);
//		self.timeRemainingLabel.frame = CGRectOffset(self.timeRemainingLabel.frame, 0, -50);
//		self.otherLabels.frame = CGRectOffset(self.otherLabels.frame, 0, -50);
		[UIView commitAnimations];
		self.bannerIsVisible = YES;
		
	//	NSLog(@"banner.frame %f",banner.frame.origin.x);
	//	NSLog(@"banner.frame %f",banner.frame.origin.y);
	//	NSLog(@"banner.frame %f",banner.frame.size.width);
	//	NSLog(@"banner.frame %f",banner.frame.size.height);
		

	}
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
NSLog(@"didFailToReceiveAdWithError %@",[error localizedDescription]);
	if (self.bannerIsVisible) {
		[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// banner is visible and we move it out of the screen, due to connection issue
		banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
		self.overallView.frame = CGRectOffset(self.overallView.frame, 0, -50);
		[UIView commitAnimations];
		self.bannerIsVisible = NO;
		
	//	NSLog(@"banner.frame %f",banner.frame.origin.x);
	//	NSLog(@"banner.frame %f",banner.frame.origin.y);
	//	NSLog(@"banner.frame %f",banner.frame.size.width);
	//	NSLog(@"banner.frame %f",banner.frame.size.height);
	}
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
	NSLog(@"ForumRootViewController willLeaveApplication");
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner {
	NSLog(@"ForumRootViewController bannerViewActionDidFinish");
}

//- (void)createBannerView {
//	
//	
//	
//    Class cls = NSClassFromString(@"ADBannerView");
//    if (cls) {
//		NSLog(@"cls");
//        NSString *MycontentSizeIdentifierPortrait = ADBannerContentSizeIdentifierPortrait;
//
//        ADBannerView *adView = [[cls alloc] initWithFrame:CGRectZero];
//        adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:MycontentSizeIdentifierPortrait,nil];
//		
//        // Set the current size based on device orientation
//        adView.currentContentSizeIdentifier = MycontentSizeIdentifierPortrait;
//        adView.delegate = self;
//
//        // Set intital frame to be offscreen
//        CGRect bannerFrame = adView.frame;
//        bannerFrame.origin.y = -50;
//        adView.frame = bannerFrame;
//
//        self.bannerView = adView;
//        [self.view addSubview:self.bannerView];
//        [adView release];
//
//    }
//	
//}
//
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
//	if (!self.bannerIsVisible) {
//		[UIView beginAnimations:@"animateAdBannerOn" context:NULL];
//		// banner is invisible now and moved out of the screen on 50 px
//		banner.frame = CGRectOffset(banner.frame, 0, 50);
//		self.overallView.frame = CGRectOffset(self.overallView.frame, 0, 50);
//		[UIView commitAnimations];
//		self.bannerIsVisible = YES;
//	}
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
//	if (self.bannerIsVisible) {
//		[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
//		// banner is visible and we move it out of the screen, due to connection issue
//		banner.frame = CGRectOffset(banner.frame, 0, -50);
//		self.overallView.frame = CGRectOffset(self.overallView.frame, 0, -50);
//		[UIView commitAnimations];
//		self.bannerIsVisible = NO;
//	}
//}
//
//
//-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
//	NSLog(@"ForumRootViewController willLeaveApplication");
//    return YES;
//}
//
//-(void)bannerViewActionDidFinish:(ADBannerView *)banner {
//	NSLog(@"ForumRootViewController bannerViewActionDidFinish");
//}
//



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//	NSLog(@"Recieved memory warning");
//	self.pictureview.image = nil;
//	for (id btn in self.calendarcurrent.dayButtons) {
//		[btn setBackgroundImage:nil forState:UIControlStateNormal];
//		[btn setBackgroundImage:nil forState:UIControlStateHighlighted];
//	}
}

- (void)viewDidUnload {
    if (self.bannerView) {
        bannerView.delegate = nil;
        self.bannerView = nil;
	}

}

@end

