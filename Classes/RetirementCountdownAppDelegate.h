//
//  RetirementCountdownAppDelegate.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/14/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.


//  Version 1.1
//     changed label on annual days off in retirement year.
//     changed retirement date tableview cell to only go to current date when first creating the datepicker, so user can't reset it



//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define WorkScheduleSelected @"WorkScheduleSelected"
#define DaySelectedForTwoWeekSchedule @"DaySelectedForTwoWeekSchedule"
#define DaysForTwoWeekSchedule @"DaysForTwoWeekSchedule"
	
@interface RetirementCountdownAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableDictionary *settings;
	NSMutableArray *workdays;
    NSMutableArray *shiftworkdays;
    NSMutableArray *shiftweek;
	NSMutableArray *holidaylist;
	NSMutableArray *manualworkdays;
	NSMutableArray *backgroundColors;
	// 0; Today
	// 1; RetirementDay
	// 2; Workdays
	// 3; Non Workdays
	// 4; Holidays
	// 5; Manual Workdays
	// 6; Manual Non Workdays
	// 7; Current Calendar Background Color
	// 8: Current Predefined Background Color - used?
	NSMutableArray *textColors;
	// 0; Today
	// 1; RetirementDay
	// 2; Workdays
	// 3; Non Workdays
	// 4; Manual Workdays
	// 5; Manual Non Workdays
	// 6; Holidays
	// 7; Current Calendar textColor
	// 8: Current Predefined textColor  -  not used
	NSMutableDictionary *colorSettings;
	NSMutableDictionary *imageCache;
	BOOL colorsChanged;
	BOOL pictureChanged;
	NSUInteger newdata;
	NSUInteger holidayMonth;
	NSUInteger holidayDay;
	NSUInteger holidayWeekday;
	NSUInteger holidayOrdinalWeekday;
	NSInteger thisYearDaysOff;
	NSInteger allYearsDaysOff;
	NSInteger retirementYearDaysOff;
//    CLLocationManager *locationManager;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableDictionary *settings;
@property (nonatomic, retain) NSMutableArray *workdays;
@property (nonatomic, strong )NSMutableArray *shiftworkdays;
@property (nonatomic, retain) NSMutableArray *shiftweeks;
@property (nonatomic, strong) NSMutableArray *allShifts;
@property (nonatomic, retain) NSMutableArray *holidaylist;
@property (nonatomic, retain) NSMutableArray *manualworkdays;
@property (nonatomic, retain) NSMutableArray *backgroundColors;
@property (nonatomic, retain) NSMutableArray *textColors;
@property (nonatomic, retain) NSMutableDictionary *colorSettings;
@property (nonatomic, retain) NSMutableDictionary *imageCache;
@property (nonatomic, assign) BOOL colorsChanged;
@property (nonatomic, assign) BOOL pictureChanged;
@property (nonatomic, assign) NSUInteger newdata;
@property (nonatomic, assign) NSUInteger holidayMonth;
@property (nonatomic, assign) NSUInteger holidayDay;
@property (nonatomic, assign) NSUInteger holidayWeekday;
@property (nonatomic, assign) NSUInteger holidayOrdinalWeekday;
@property (nonatomic, assign) NSInteger thisYearDaysOff;
@property (nonatomic, assign) NSInteger allYearsDaysOff;
@property (nonatomic, assign) NSInteger retirementYearDaysOff;
//@property (retain, nonatomic) CLLocationManager *locationManager;


-(void) CreateDatabases;
-(void)loadworkdays;
-(void) saveworkdays;
-(void)loadmanualworkdays;
-(void) savemanualworkdays;
-(void) loadsettings;
-(void) savesettings;
-(void)loadBackgroundColors;
-(void)saveBackgroundColors;
-(void)loadTextColors;
-(void)saveTextColors;
-(void)loadColorSettings;
-(void)saveColorSettings;
-(void)saveHolidayList;
-(void)loadHolidayList;
-(void) saveAllData;
-(void)tableView;

- (UIImage*)imageFromCache:(NSString*)fileName;



@end

