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
#import "iAd/iAd.h"


#define kCalendarwidth 315
#define kCalendarContainerwidth 320
#define kCalendarDaysleft 4
#define kCalendarDaystop 45
#define kCalendarDaysHeight4 153+12
#define kCalendarDaysHeight5 191+12
#define kCalendarDaysHeight6 230+12



@interface RootViewController : BaseViewController <MFMailComposeViewControllerDelegate,  UIActionSheetDelegate, ADBannerViewDelegate> {


	Calendar				*calendarcurrent;
    IBOutlet UILabel		*monthNameLabel;
	IBOutlet UILabel		*yearLabel;
	IBOutlet UILabel		*monthLabel; 
	IBOutlet UILabel		*dayLabel;
	IBOutlet UILabel		*workDaysLabel;
	IBOutlet UILabel		*hoursLabel;
	IBOutlet UILabel		*minutesLabel;
	IBOutlet UILabel		*secondsLabel;
    IBOutlet UILabel		*notWorkingLabel;
	IBOutlet UILabel		*otherLabels;
    IBOutlet UILabel		*calendarLabel;
    IBOutlet UILabel		*calendarDaysLabels;
    IBOutlet UILabel		*workLabel;
    IBOutlet UILabel		*workLeftLabels;
	int						daysleft;
	int						hoursleft; 
	int						minutesleft;	
	int						secondsleft;  
	int						totalsecondsleft;
	IBOutlet UIView			*overallView;
	IBOutlet UIView			*containerview;	
	IBOutlet UIView			*calendarview;
	IBOutlet UIView			*calendarnavview;	
	IBOutlet UIView			*calendardaysview;
	IBOutlet UIView			*swipeview;
	IBOutlet UIImageView	*pictureview;	
	BOOL					transitioning;
	NSDate					*retirementDate;
	NSMutableArray			*settings;
	CGPoint					startTouchPosition;
	NSString				*displayoption;
	NSTimer					*timer;
	IBOutlet UIButton		*prevYearButton;
	IBOutlet UIButton		*prevMonthButton;
	IBOutlet UIButton		*nextMonthButton;
	IBOutlet UIButton		*nextYearButton;
	NSUInteger				tapCount;
	UIView	*navbarView;
	ADBannerView *bannerView;
	BOOL bannerIsVisible;
	


	
	NSTimer *updateTimer;
	
	
}


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

@property (nonatomic, assign) int totalsecondsleft;
@property (nonatomic, assign) int daysleft; 
@property (nonatomic, assign) int hoursleft; 
@property (nonatomic, assign) int minutesleft;
@property (nonatomic, assign) int secondsleft;


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

@property (nonatomic,assign) BOOL bannerIsVisible;
@property(nonatomic, retain) ADBannerView *bannerView;




@property (nonatomic, retain) NSTimer *updateTimer;



-(void)updateNavigationBarTitle;
-(NSData*)capturescreen;
-(void)flipView;
-(void) fliptoCalendarWithAnimation:(BOOL)animated;
-(void) fliptoPictureWithAnimation:(BOOL)animated;
-(IBAction)showSettingsView:(id)sender;
-(void)updatelabelsWithReset:(bool)reset;
-(void)starttimer;
-(void)timerMode;
-(NSInteger)getviewheight;
-(void)GotoToday;
-(void)GotoRetirementDay;
- (IBAction)prevMonth:(id)sender;
- (IBAction)nextMonth:(id)sender;
- (IBAction)prevYear:(id)sender;
- (IBAction)nextYear:(id)sender;
-(void)performTransition:(NSInteger)direction;
- (void)daySelectedDoubleTap:(id)sender;
- (void)daySelectedSingleTap:(id)sender;
-(void)resetTapCount:(id)sender;
- (void)dayButtonTapped:(id)sender;
-(void) showGotoView;
//-(void) loadAd;
-(void)sendEmail;
-(void) updateCalendarAndLabels:(NSTimer*)theTimer;
- (void)createBannerView;
@end
