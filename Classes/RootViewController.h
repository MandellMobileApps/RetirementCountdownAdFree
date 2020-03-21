//
//  RootViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/14/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Calendar.h"
#import "BaseViewController.h"


#define kCalendarwidth 315
#define kCalendarContainerwidth 320
#define kCalendarDaysleft 4
#define kCalendarDaystop 45
#define kCalendarDaysHeight4 153+12
#define kCalendarDaysHeight5 191+12
#define kCalendarDaysHeight6 230+12






@interface RootViewController : BaseViewController <MFMailComposeViewControllerDelegate, CAAnimationDelegate> {


	
	
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIView *busyView; 

@property (nonatomic, retain) Calendar	*calendarcurrent;
@property (nonatomic, retain) IBOutlet UILabel *otherLabels; 

@property (nonatomic, retain) IBOutlet UILabel *monthNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel; 
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;
@property (nonatomic, retain) IBOutlet UILabel *workDaysLabel;
@property (nonatomic, retain) IBOutlet UILabel *hoursLabel;
@property (nonatomic, retain) IBOutlet UILabel *minutesLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondsLabel;
@property (nonatomic, retain) IBOutlet UILabel *notWorkingLabel;

@property (nonatomic, retain) IBOutlet UILabel *calendarLabel;
@property (nonatomic, retain) IBOutlet UILabel *calendarDaysLabels;
@property (nonatomic, retain) IBOutlet UILabel *workLabel;
@property (nonatomic, retain) IBOutlet UILabel *workLeftLabels;

@property (nonatomic, assign) NSInteger totalsecondsleft;
@property (nonatomic, assign) NSInteger daysleft;
@property (nonatomic, assign) NSInteger hoursleft;
@property (nonatomic, assign) NSInteger minutesleft;
@property (nonatomic, assign) NSInteger secondsleft;


@property (nonatomic, retain) IBOutlet UIButton		*prevYearButton;
@property (nonatomic, retain) IBOutlet UIButton		*prevMonthButton;
@property (nonatomic, retain) IBOutlet UIButton		*nextMonthButton;
@property (nonatomic, retain) IBOutlet UIButton		*nextYearButton;

@property (nonatomic, retain) IBOutlet UIView *overallView;
@property (nonatomic, retain) IBOutlet UIView *containerview;
@property (nonatomic, retain) IBOutlet UIView *calendarview;
@property (nonatomic, retain) IBOutlet UIView *calendarnavview;
@property (nonatomic, retain) IBOutlet UIView	*calendardaysview;
@property (nonatomic, retain) IBOutlet UIView *swipeview;
@property (nonatomic, retain) IBOutlet UIImageView *pictureview;

@property (nonatomic, assign) BOOL transitioning;
@property (nonatomic, retain) NSDate *retirementDate;
@property (nonatomic, retain) NSMutableArray *settings;
@property (nonatomic, assign) CGPoint startTouchPosition;
@property (nonatomic, retain) NSString *displayoption;
@property (nonatomic, retain) NSTimer	*timer;
@property (nonatomic, assign) NSUInteger tapCount;

@property (nonatomic, retain) UIView	*navbarView;

@property (nonatomic, retain) NSTimer *updateTimer;

@property (nonatomic, retain) IBOutlet UILabel *annualLabel;
@property (nonatomic, retain) IBOutlet UILabel *annual2Label;

@property (nonatomic, retain) IBOutlet UIButton        *forceUpdateButton;

//@property (nonatomic, assign) BOOL firstLoad;

-(void)refreshRootViewController;
-(void)updateNavigationBarTitle;
-(NSData*)capturescreen;
-(void)flipView;
-(void) fliptoCalendarWithAnimation:(BOOL)animated;
-(void) fliptoPictureWithAnimation:(BOOL)animated;
-(IBAction)showSettingsView:(id)sender;
-(void)updatelabelsWithReset:(bool)reset;
-(void)timerMode;
-(CGRect)getCalendarDaysFrame;
-(void)GotoToday;
-(void)GotoRetirementDay;
- (IBAction)prevMonth:(id)sender;
- (IBAction)nextMonth:(id)sender;
- (IBAction)prevYear:(id)sender;
- (IBAction)nextYear:(id)sender;
-(void)performTransition:(NSInteger)direction;


-(void) showGotoView;


@end
