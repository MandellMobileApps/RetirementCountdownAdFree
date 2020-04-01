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
#import <StoreKit/StoreKit.h>
#import "UpgradeNoticeViewController.h"


@implementation RootViewController




#pragma mark -
#pragma mark View lifecycle



- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.appDelegate.colorsChanged = YES;
    
	UIBarButtonItem *settingsBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingsView:)];
	self.navigationItem.rightBarButtonItem = settingsBarItem;

	
	UIBarButtonItem *gotoBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showGotoView)];
	self.navigationItem.leftBarButtonItem = gotoBarItem;

    [self refreshRootViewController];

	Calendar *calendarcurrentTemp = [[Calendar alloc] initWithHandler:self];
	self.calendarcurrent = calendarcurrentTemp;
    [self.calendardaysview addSubview:self.calendarcurrent];
    
    BOOL showUpgradeNotice = [[NSUserDefaults standardUserDefaults] boolForKey:@"showUpgradeNotice"];
    if (showUpgradeNotice)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showUpgradeNoticeThisTime"];
    }

//    [SKStoreReviewController requestReview];

}

//- (void)DisplayReviewController {
//    if (@available(iOS 10.3, *)) {
//        [SKStoreReviewController requestReview];
//    }
//}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    if(self.appDelegate.colorsChanged == YES) {
        [self updateColors];
        self.appDelegate.colorsChanged = NO;
    }

    if (self.appDelegate.settingsChanged)
    {
        [self refreshRootViewController];
        self.appDelegate.settingsChanged = NO;
    }
    
    [self.calendarcurrent drawCalendarToCurrentMonth];
    self.calendardaysview.frame = [self getCalendarDaysFrame];


    if ([self.appDelegate.settingsNew.currentDisplay isEqualToString:@"Picture"]) {
        [self fliptoPictureWithAnimation:self.appDelegate.pictureChanged];
        self.appDelegate.pictureChanged = NO;
    }
    


    NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li", [self.calendarcurrent currentMonthName],(long)[self.calendarcurrent currentYear]];
    
    self.monthNameLabel.text = monthyearlabeltemp;

    [self updatelabelsWithReset:YES];

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateNavigationBarTitle];

    BOOL showUpgradeNoticeThisTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"showUpgradeNoticeThisTime"];

    if (showUpgradeNoticeThisTime)
    {
        [self performSelector:@selector(displayUpgradeNotice) withObject:nil afterDelay:0.5];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showUpgradeNoticeThisTime"];
    }
    else
    {
        [self performSelector:@selector(capturescreen) withObject:nil afterDelay:1.0];
    }
    

}

-(void) viewWillDisappear:(BOOL)animated {

    [self.navbarView removeFromSuperview];
    [super viewWillDisappear:animated];

}

#pragma mark -
#pragma mark Update Data

-(void)showBusyView:(BOOL)load
{
    

    if (load)
    {
        CGRect thisFrame = CGRectMake(50, 100, self.view.bounds.size.width-100, 100);
        self.busyView = [[UIView alloc]initWithFrame:thisFrame];
        self.busyView.backgroundColor = [GlobalMethods colorForIndex:3];
        self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        CGRect activtyFrame = CGRectMake((self.busyView.bounds.size.width-self.activityView.bounds.size.width)/2, (self.busyView.bounds.size.height - self.activityView.bounds.size.height)/2, self.activityView.bounds.size.width, self.activityView.bounds.size.height);
        self.activityView.frame = activtyFrame;
        [self.busyView addSubview:self.activityView];
        [self.activityView startAnimating];
        [self.view addSubview:self.busyView];
        
    }
    else
    {
        [self.activityView removeFromSuperview];
        [self.busyView removeFromSuperview];

    }

    
}




-(void)updateNavigationBarTitle {
  


    NSInteger year = self.appDelegate.settingsNew.retirementYear;
    NSInteger month = self.appDelegate.settingsNew.retirementMonth;
    NSInteger day = self.appDelegate.settingsNew.retirementDay;
    NSString* monthName = [GlobalMethods nameOfMonthForInt:month];
    
    NSString* retirementDateString = [NSString stringWithFormat:@"%@ %li, %li",monthName,day,year];
    
	UIView *navTitleView	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	navTitleView.backgroundColor = [UIColor clearColor]; 
	self.navbarView = navTitleView;
	
	UILabel *navTitleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 320, 28)];
	navTitleLabel1.text = @"Retirement Countdown";
	navTitleLabel1.backgroundColor = [UIColor clearColor]; 
	navTitleLabel1.textColor = [UIColor whiteColor]; 
	navTitleLabel1.font = [UIFont boldSystemFontOfSize:16];
	navTitleLabel1.textAlignment = NSTextAlignmentCenter;

	UILabel *navTitleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,25, 320, 16)];
	navTitleLabel2.text = [NSString stringWithFormat:@"to  %@",retirementDateString];  
	navTitleLabel2.backgroundColor = [UIColor clearColor]; 
	navTitleLabel2.textColor = [UIColor whiteColor]; 
	navTitleLabel2.font = [UIFont systemFontOfSize:14];
	navTitleLabel2.textAlignment = NSTextAlignmentCenter;
	
	[navTitleView addSubview:navTitleLabel1];
	[navTitleView addSubview:navTitleLabel2];

	[self.navigationController.navigationBar addSubview:self.navbarView];

	
}

-(void)refreshRootViewController
{
    [self.appDelegate addToDebugLog:@"refreshRootViewController" ofType:DebugLogTypeNav];
    //[self showBusyView:YES];
    
    if (self.appDelegate.needsUpgradeConverstion ==1)
    {
        [self.appDelegate upgradeToSQLVersion];
        [self.appDelegate updateDaysInDayTable];
        [self.appDelegate upgradeManualDays];
        self.appDelegate.needsUpgradeConverstion = 0;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showUpgradeNotice"];
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showUpgradeNoticeThisTime"];

    }

    [self updateColors];
    [self.appDelegate refreshSettings];
    [self.appDelegate updateDaysInDayTable];
    [self updatelabelsWithReset:YES];
   // [self showBusyView:NO];
    
 
}
-(void)updateColors
{

    UIColor *defaultBackgroundColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.backgroundColorIndex];

    self.view.backgroundColor = defaultBackgroundColor;
    self.overallView.backgroundColor = defaultBackgroundColor;
    self.calendardaysview.backgroundColor =  defaultBackgroundColor;
    self.calendarnavview.backgroundColor =  defaultBackgroundColor;
    self.calendarview.backgroundColor =    defaultBackgroundColor;
    self.containerview.backgroundColor =    defaultBackgroundColor;
    self.prevYearButton.backgroundColor = defaultBackgroundColor;
    self.prevMonthButton.backgroundColor = defaultBackgroundColor;
    self.nextMonthButton.backgroundColor = defaultBackgroundColor;
    self.nextYearButton.backgroundColor = defaultBackgroundColor;
    self.monthNameLabel.backgroundColor = defaultBackgroundColor;
    self.pictureview.backgroundColor = defaultBackgroundColor;
    self.notWorkingLabel.backgroundColor = defaultBackgroundColor;
    
    [self.calendarcurrent reloadWeekdayNameLabels];
    
    UIColor *defaultTextColor = [GlobalMethods colorForIndex:self.appDelegate.settingsNew.textColorIndex];

    self.monthNameLabel.textColor = defaultTextColor;
    self.otherLabels.textColor = defaultTextColor;
    self.calendarLabel.textColor = defaultTextColor;
    self.calendarDaysLabels.textColor = defaultTextColor;
    self.workLabel.textColor = defaultTextColor;
    self.workLeftLabels.textColor = defaultTextColor;
    self.notWorkingLabel.textColor = defaultTextColor;
 
}


-(NSData*)capturescreen {
    

	UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
	UIImage *screencapture = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext(); 
	NSData *imageinpng = UIImagePNGRepresentation(screencapture);
	NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"lastScreenCapture"];
	[imageinpng writeToFile:pathName atomically:YES];
	NSData *returnData = [[NSData alloc] initWithData:imageinpng];
   
    
    
	return returnData;
}

#pragma mark -
#pragma mark Email Methods

-(void)sendEmail {

		MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
		mailcontroller.mailComposeDelegate = self;
		[mailcontroller addAttachmentData:[self capturescreen] mimeType:@"image/png" fileName:@"Retirement Countdown"];
        [self presentViewController:mailcontroller animated:YES completion:nil];
        [self.appDelegate addToDebugLog:@"Nav - sendEmail" ofType:DebugLogTypeNav];
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
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Calendar/Picture Methods

-(void)flipView {
    if ([self.pictureview superview]) {
        [self fliptoCalendarWithAnimation:YES];
         [self.appDelegate addToDebugLog:@"Nav - flipView to Calendar" ofType:DebugLogTypeNav];
        
    } else {
        [self fliptoPictureWithAnimation:YES];
         [self.appDelegate addToDebugLog:@"Nav - flipView to Picture" ofType:DebugLogTypeNav];
        
    }
   
}

//+ (void)transitionWithView:(UIView *)view
//  duration:(NSTimeInterval)duration
//   options:(UIViewAnimationOptions)options
//animations:(void (^)(void))animations
//completion:(void (^)(BOOL finished))completion;


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
    [self.appDelegate updateSettingsString:@"Calendar" forProperty:@"currentDisplay"];


}

-(void) fliptoPictureWithAnimation:(BOOL)animated {
    
    NSString* fullImageName;
    if (self.appDelegate.settingsNew.customPicture == 0)
    {
        fullImageName = [GlobalMethods fullImageNameFor:DefaultPicture];
    }
    else
    {
        fullImageName = [GlobalMethods fullImageNameFor:CustomPicture];
        
    }
    UIImage* tempImage =[UIImage imageWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:fullImageName]];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:tempImage];
    tempImageView.frame = CGRectMake(0, 0, 320, 300);
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.pictureview = tempImageView;
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
 
     [self.appDelegate updateSettingsString:@"Picture" forProperty:@"currentDisplay"];
 

}


#pragma mark -
#pragma mark Load ViewController Methods

-(IBAction)showSettingsView:(id)sender {
    RCSettingsViewController *rcsettingsViewController = [[RCSettingsViewController alloc] initWithNibName:@"RCSettings" bundle:nil];
    rcsettingsViewController.title = @"Settings";
    [[self navigationController] pushViewController:rcsettingsViewController animated:YES];
    [self.appDelegate addToDebugLog:@"Nav - SettingsView" ofType:DebugLogTypeNav];


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
    self.displayoption = self.appDelegate.settingsNew.displayOption;
     if ([self.timer isValid] == YES){
        [self.timer invalidate];
    }
    TimeRemaining *myTimeRemaining = [[TimeRemaining alloc] init];
    [myTimeRemaining updateTimeRemaining];
    
    if (self.appDelegate.calendarYearsLeft < 0)
    {
         [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"updatelabels Before Retry %li",(long)self.appDelegate.calendarYearsLeft] ofType:DebugLogTypeTime];
         [self updateColors];
         [self.appDelegate refreshSettings];
         [self.appDelegate updateDaysInDayTable];
        [myTimeRemaining updateTimeRemaining];
        [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"updatelabels After Retry %li",(long)self.appDelegate.calendarYearsLeft] ofType:DebugLogTypeTime];
    }
    
 
    self.daysleft = self.appDelegate.totalWorkdays;
    self.totalsecondsleft = self.appDelegate.secondsLeftToday;
    NSNumber* daysLeftNumber = [NSNumber numberWithInteger:self.appDelegate.totalWorkdays];
    NSString* daysLeftString = [NSNumberFormatter localizedStringFromNumber:daysLeftNumber numberStyle:NSNumberFormatterDecimalStyle];
	self.workDaysLabel.text = daysLeftString;

    
    if (self.totalsecondsleft > 0) {
        [self setTimerForRemaining];
		self.notWorkingLabel.hidden = YES;
    }
    else
    {
    	self.notWorkingLabel.hidden = NO;
        self.hoursLabel.text = @"0";
        self.minutesLabel.text = @"0";
        self.secondsLabel.text = @"0";
    }
    
    self.secondsleft = self.totalsecondsleft % 60;
    self.minutesleft = self.totalsecondsleft / 60;
    self.hoursleft = self.minutesleft / 60;
    self.minutesleft = self.minutesleft % 60;

    self.hoursLabel.text = [NSString stringWithFormat:@"%li",(long)self.hoursleft];
    self.minutesLabel.text = [NSString stringWithFormat:@"%li",(long)self.minutesleft];
    self.secondsLabel.text = [NSString stringWithFormat:@"%li",(long)self.secondsleft];
 
    self.yearLabel.text =[NSString stringWithFormat:@"%li",(long)self.appDelegate.calendarYearsLeft];
    self.monthLabel.text = [NSString stringWithFormat:@"%li",(long)self.appDelegate.calendarMonthsLeft];
    self.dayLabel.text = [NSString stringWithFormat:@"%li",(long)self.appDelegate.calendarDaysLeft];
    
    if (self.appDelegate.totalAnnualDaysOff>0)
    {
        self.annualLabel.text =[NSString stringWithFormat:@"Includes %li",(long)self.appDelegate.totalAnnualDaysOff];
        self.annualLabel.hidden = NO;
        self.annual2Label.hidden = NO;
    }
    else
    {
        self.annualLabel.hidden = YES;
        self.annual2Label.hidden = YES;
    }
    
  
}


-(void)setTimerForRemaining
{

    [self timerMode];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMode) userInfo:nil repeats:YES];
    
}


-(void)timerMode {

	if (self.totalsecondsleft <= 1) {
		[self.timer invalidate];
		self.timer = nil; 
	}
	self.totalsecondsleft--;
 
    self.secondsleft = self.totalsecondsleft % 60;
    self.minutesleft = self.totalsecondsleft / 60;
    self.hoursleft = self.minutesleft / 60;
    self.minutesleft = self.minutesleft % 60;
 
 
//    NSNumber* daysLeftNumber = [NSNumber numberWithInteger:self.daysleft];
//    NSString* daysLeftString = [NSNumberFormatter localizedStringFromNumber:daysLeftNumber numberStyle:kCFNumberFormatterDecimalStyle];
//	self.workDaysLabel.text = daysLeftString;
    self.workDaysLabel.text = [NSString stringWithFormat:@"%li",(long)self.daysleft];
    self.hoursLabel.text = [NSString stringWithFormat:@"%li",(long)self.hoursleft];
    self.minutesLabel.text = [NSString stringWithFormat:@"%li",(long)self.minutesleft];
    self.secondsLabel.text = [NSString stringWithFormat:@"%li",(long)self.secondsleft];
}

-(CGRect)getCalendarDaysFrame {

	NSInteger totalweeks = self.calendarcurrent.totalweeks;

	NSInteger height = 0;
	if(totalweeks == 4) {
		height = kCalendarDaysHeight4;
	}	
	if(totalweeks == 5) {
		height = kCalendarDaysHeight5;
	}	
	if(totalweeks == 6) {
		height = kCalendarDaysHeight6;
	}
   
    CGRect frame = CGRectMake(kCalendarDaysleft, kCalendarDaystop, kCalendarwidth, height);

	return frame;
}


-(void)GotoToday {
   
    
    if ([self.appDelegate.settingsNew.currentDisplay isEqualToString:@"Picture"]) {
        [self fliptoCalendarWithAnimation:YES];
         
    }
    [self performTransition:3];
    [self.calendarcurrent gotoToday];
    [self.calendardaysview setFrame:[self getCalendarDaysFrame]];

    NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
    self.monthNameLabel.text = monthyearlabeltemp;
  
   [self.appDelegate addToDebugLog:@"Nav - GotoToday" ofType:DebugLogTypeNav];

}




-(void)GotoRetirementDay {

	if ([self.appDelegate.settingsNew.currentDisplay isEqualToString:@"Picture"]) {
		[self fliptoCalendarWithAnimation:YES];
	}
	[self performTransition:3];
	[self.calendarcurrent gotoRetirementDay];
	[self.calendardaysview setFrame:[self getCalendarDaysFrame]];

	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;
    [self.appDelegate addToDebugLog:@"Nav - GotoRetirementDay" ofType:DebugLogTypeNav];

}


- (IBAction)prevMonth:(id)sender { 
	if(!self.transitioning)
	{
		[self performTransition:1];
		[self.calendarcurrent previousMonth];
		[self.calendardaysview setFrame:[self getCalendarDaysFrame]];

		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;

	}
	
}

- (IBAction)nextMonth:(id)sender { 
	if(!self.transitioning)
	{
		[self performTransition:2];
		[self.calendarcurrent nextMonth];
		[self.calendardaysview setFrame:[self getCalendarDaysFrame]];

		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;

	}
}


- (IBAction)prevYear:(id)sender {
	if(!self.transitioning)
	{
		[self performTransition:1];
		[self.calendarcurrent previousYear];
		[self.calendardaysview setFrame:[self getCalendarDaysFrame]];
		NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
		self.monthNameLabel.text = monthyearlabeltemp;

	}
}

- (IBAction)nextYear:(id)sender { 
	[self performTransition:2];
	[self.calendarcurrent nextYear];

	[self.calendardaysview setFrame:[self getCalendarDaysFrame]];

	NSString *monthyearlabeltemp  = [[NSString alloc] initWithFormat:@"%@  %li",[self.calendarcurrent currentMonthName], (long)[self.calendarcurrent currentYear]];
	self.monthNameLabel.text = monthyearlabeltemp;

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



-(void) showGotoView {
  
	[self.appDelegate addToDebugLog:@"Nav - GoToView" ofType:DebugLogTypeNav];
    
    NSString *pictureStatus;
	if ([self.appDelegate.settingsNew.currentDisplay isEqualToString:@"Calendar"]) {
		pictureStatus = @"Display Picture";
	} else {
		pictureStatus = @"Display Calendar";
	}
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"What do you want to do?" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *button1 = [UIAlertAction actionWithTitle:@"Go To Today"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                        [self GotoToday];
                                                   }];
    UIAlertAction *button2 = [UIAlertAction actionWithTitle:@"Go To Retirement Date"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       [self GotoRetirementDay];
                                                   }];
 
    UIAlertAction *button3 = [UIAlertAction actionWithTitle:pictureStatus
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       [self flipView];
                                                   }];
    
    UIAlertAction *button4 = [UIAlertAction actionWithTitle:@"Send Email"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       [self sendEmail];
                                                   }];
    UIAlertAction *button5 = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       //add code to make something happen once tapped
                                                [self.appDelegate addToDebugLog:@"Nav - cancel GoToView" ofType:DebugLogTypeNav];
                                                   }];
//    [button1 setValue:[[UIImage imageNamed:@"beach.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];

    [alertVC addAction:button1];
    [alertVC addAction:button2];
    [alertVC addAction:button3];
    [alertVC addAction:button4];
    [alertVC addAction:button5];
    
    [self presentViewController:alertVC animated:YES completion:nil];

    
//    UIAlertController *actionSheet = [[UIAlertController alloc] initWithPreferredStyle:UIAlertControllerStyleActionSheet];
//
//    actionSheet.preferredStyle = UIAlertControllerStyleActionSheet;
//                                      initWithTitle:@" " delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Go To Today",@"Go To Retirement Date",pictureStatus, @"Send Email",nil];
//	actionSheet.tag = 1;
//	[actionSheet showInView:self.containerview];

}


//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//	if (actionSheet.tag == 1) {
//		if(buttonIndex == 0) {
//			[self GotoToday];
//		} else if (buttonIndex == 1) {
//			[self GotoRetirementDay];
//		} else if (buttonIndex == 2) {
//			[self flipView];
//		} else if (buttonIndex == 3) {
//			[self sendEmail];
//		}
////	} else if (actionSheet.tag == 2) {
////		if(buttonIndex == 0) {
////			[self.appDelegate.settings setObject:@"NO" forKey:@"FirstTimeLoad"];
////			[self.appDelegate saveAllData];
////		}
////	}
//}

//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
//	if (actionSheet.tag == 2) {
//		UIImageView *settingsButton  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SettingsButton.png"]];
//		settingsButton.frame = CGRectMake(20, 50, 49, 34);
//		[actionSheet addSubview:settingsButton];
//
//	}
	
//}


-(void)displayUpgradeNotice
{
    UpgradeNoticeViewController *upgradeNoticeViewController = [[UpgradeNoticeViewController alloc] initWithNibName:@"UpgradeNoticeViewController" bundle:nil];
    [[self navigationController] pushViewController:upgradeNoticeViewController animated:YES];

}

#pragma mark -
#pragma mark Not Used Methods


- (void) pushVC:(UIViewController*)dstVC {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:dstVC animated:NO];
}


- (void) popVC {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

@end

