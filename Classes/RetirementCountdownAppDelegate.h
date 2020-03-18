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
#import "GlobalMethods.h"
#import "ColorsClass.h"
#import "Date.h"
#import "SettingsNew.h"
#import "SQLiteAccess.h"

@class TimeRemaining;
@class RootViewController;

static NSInteger imageStart = 1;
static NSInteger imageEnd  = 14;
static NSInteger imageCount  = 14;

static NSInteger holidayImageStart = 101;
static NSInteger holidayImageEnd = 115;
static NSInteger holidayImageCount = 15;

//#define WorkScheduleSelected @"WorkScheduleSelected"
//#define DaySelectedForTwoWeekSchedule @"DaySelectedForTwoWeekSchedule"
//#define DaysForTwoWeekSchedule @"DaysForTwoWeekSchedule"

#define DefaultPicture @"beach"
#define CustomPicture @"customPicture"

@interface RetirementCountdownAppDelegate : NSObject <UIApplicationDelegate,NSKeyedArchiverDelegate> {

	
}

@property (nonatomic, retain) RootViewController *rootViewController;

@property (nonatomic, retain) SettingsNew *settingsNew;
//@property (nonatomic, retain) NSDictionary *settingsDictionary;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, assign) BOOL colorsChanged;
@property (nonatomic, assign) BOOL pictureChanged;
@property (nonatomic, assign) BOOL settingsChanged;

@property (nonatomic, assign) NSUInteger firstLaunch;
@property (nonatomic, assign) BOOL notificationPermissiongranted;

@property (nonatomic, assign) NSUInteger badgeDaysOff;

@property (nonatomic, assign) NSUInteger secondsLeftToday;
@property (nonatomic, assign) NSUInteger totalWorkdays;
@property (nonatomic, assign) NSInteger totalAnnualDaysOff;

@property (nonatomic, assign) NSUInteger calendarDaysLeft;
@property (nonatomic, assign) NSUInteger calendarMonthsLeft;
@property (nonatomic, assign) NSUInteger calendarYearsLeft;

@property (nonatomic, assign) NSInteger needsUpgradeConverstion;


-(void)updateIconBadge;
-(void)addToDebugLog:(NSString*)message;


-(void)updateSettingsString:(NSString*)value  forProperty:(NSString*)propertyName;
-(void)updateSettingsInteger:(NSInteger)value  forProperty:(NSString*)propertyName;;
-(void)insertIntoTable:(NSString*)table forDictionary:(NSDictionary*)dictionary;
-(void)updateTable:(NSString*)table forDictionary:(NSDictionary*)dictionary;

-(void)refreshSettings;
-(void)updateDaysInDayTable;

-(void)upgradeToSQLVersion;
-(void)upgradeManualDays;


@property (nonatomic, assign) BOOL inTestingMode;



//-(void) CreateDatabases;
//-(void)loadworkdays;
//-(void) saveworkdays;
//-(void) loadsettings;
//-(void) savesettings;
//-(void)loadBackgroundColors;
//-(void)saveBackgroundColors;
//-(void)loadTextColors;
//-(void)saveTextColors;
//-(void)loadColorSettings;
//-(void)saveColorSettings;
//-(void)saveHolidayList;
//-(void)loadHolidayList;
//-(void) saveAllData;



//-(void)logSettings;






@end

