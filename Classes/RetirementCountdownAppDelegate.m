//
//  RetirementCountdownAppDelegate.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/14/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "RetirementCountdownAppDelegate.h"
#import "RootViewController.h"
#import "Appirater.h"
#import "TimeRemaining.h"
#import "TestFlight.h"


@implementation RetirementCountdownAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize settings;
@synthesize workdays;
@synthesize holidaylist;
@synthesize manualworkdays;
@synthesize backgroundColors;
@synthesize textColors;
@synthesize colorSettings;
@synthesize imageCache;
@synthesize colorsChanged;
@synthesize pictureChanged;
@synthesize newdata;
@synthesize holidayMonth;
@synthesize holidayDay;
@synthesize holidayWeekday;
@synthesize holidayOrdinalWeekday;
@synthesize thisYearDaysOff;
@synthesize allYearsDaysOff;
@synthesize retirementYearDaysOff;
//@synthesize locationManager;



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
 


//#ifdef LITE_VERSION
    //[TestFlight takeOff:@"032d24bb-8926-4664-978d-e3d85b4e2b6f"];
//#else
    //[TestFlight takeOff:@"c2d382e3-bd31-4d69-8f43-74f1d629c505"];
//#endif

	[self CreateDatabases];
	[self loadsettings];
	[self loadworkdays];
	[self loadHolidayList];
	[self loadmanualworkdays];
	[self loadBackgroundColors];
	[self loadTextColors];
	[self loadColorSettings];
	
	[Appirater appLaunched:YES];
    

#ifdef LITE_VERSION
	[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#else

#endif


    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [window makeKeyAndVisible];

    return YES;
}



-(int)updateIconBadge {

	int daysLeft;
	if ([[self.settings objectForKey:@"DisplayOption"] isEqualToString:@"Work"]) { 
		TimeRemaining *myTimeRemaining = [[TimeRemaining alloc] init];
        NSArray *dayAndSecondsLeft = [myTimeRemaining getTimeRemainingFor:[self.settings objectForKey:@"RetirementDate"]];
		daysLeft = [[dayAndSecondsLeft objectAtIndex:0]intValue];
        [myTimeRemaining release];
	} else if ([[self.settings objectForKey:@"DisplayOption"] isEqualToString:@"Calendar"]) {
        NSDate *today = [NSDate date];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:today toDate:[self.settings objectForKey:@"RetirementDate"] options:0];
		[gregorian release];
    	daysLeft = components.day;
	} else {
    	daysLeft = 0;
    
    }
    return daysLeft;
	
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self saveAllData];
#ifdef LITE_VERSION
	[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#else
	if ([[self.settings objectForKey:@"DisplayOption"] isEqualToString:@"None"]) {
    	[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
		if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
        	[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
        }
    }
    else
    {
		if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
        {
        	[[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:60*60*24];
        }
    	[UIApplication sharedApplication].applicationIconBadgeNumber = [self updateIconBadge];
    }
        
#endif
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	[Appirater appEnteredForeground:YES];
    [self loadsettings];
	[self loadworkdays];
	[self loadHolidayList];
	[self loadmanualworkdays];
	[self loadBackgroundColors];
	[self loadTextColors];
	[self loadColorSettings];
	[[self.navigationController.viewControllers objectAtIndex:0] viewWillAppear:NO];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}

// http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/RuntimeEnvironment/RuntimeEnvironment.html  
// Multitasking makes the relaunching of applications much faster but does not eliminate the launching of applications altogether. As memory becomes constrained, the system purges applications that have not been used recently. Purges can happen at any time and with no notice. It is therefore imperative that applications save user data and any application state when they move to the background. During the next launch cycle, the application should then use that state information to restore the application to its previous state. Restoring the application in this way makes it seem as if the application never quit, which provides continuity and convenience for the user. 
// UIApplicationExitsOnSuspend (Boolean - iOS) specifies that the application should be terminated rather than moved to the background when it is quit. Applications linked against iOS SDK 4.0 or later can include this key and set its value to YES to prevent being automatically opted-in to background execution and application suspension. When the value of this key is YES, the application is terminated and purged from memory instead of moved to the background. If this key is not present, or is set to NO, the application moves to the background as usual.
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}

#pragma mark -
#pragma mark Startup Methods

-(void) CreateDatabases {
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success;
	NSArray *databases = [[NSArray alloc] initWithObjects:
						  @"Settings.plist",
						  @"ManualWorkdays.plist",
						  @"Workdays.plist",
						  @"HolidayList.plist",
						  @"BackgroundColors.plist",
						  @"TextColors.plist",
						  @"ColorSettings.plist",
                          @"Shiftworkdays.plist",
						  nil];
	for (NSString *db in databases) {
		NSString *pathDoc = [GlobalMethods dataFilePathofDocuments:db];
		success = [fileManager fileExistsAtPath:pathDoc];
		if(!success){
			NSString *pathApp = [GlobalMethods dataFilePathofBundle:db];
			[fileManager copyItemAtPath:pathApp toPath:pathDoc error:nil];
		}
        if ([db isEqualToString:@"HolidayList.plist"])
        {
			NSMutableArray *holidays = [[NSMutableArray alloc] initWithContentsOfFile:pathDoc];
            int i = 0;
            int a = -1;
            for (NSMutableDictionary* item in holidays)
            {
            	if ([[item objectForKey:@"name"] isEqualToString:@"USA Independance Day"])
                {
                    [item setObject:@"USA Independence Day" forKey:@"name"];
                }
            	if ([[item objectForKey:@"name"] isEqualToString:@"Day after Thanksgiving"])
                {
                    a=i;
                }
                i++;
            }
            if (a>-1)
            {
            	[holidays removeObjectAtIndex:a];
            }
            BOOL ok = [holidays writeToFile:pathDoc atomically:YES];
            if (ok != YES) {NSLog(@"saveHolidayList did not save!");}
        }
	}	
	[databases release];
	
    
	
}


-(void) saveAllData {
	[self savesettings];
	[self saveworkdays];
	[self saveHolidayList];
	[self savemanualworkdays];
	[self saveBackgroundColors];
	[self saveTextColors];
	[self saveColorSettings];
}




// settings  //////////////////////////////////////	
-(void) loadsettings {
	NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"Settings.plist"]];
	if ([[tempDict objectForKey:@"RetirementYearDaysOff"] intValue] > 365) {
		[tempDict  setObject:[tempDict objectForKey:@"AllYearsDaysOff"] forKey:@"RetirementYearDaysOff"];
	}
	self.settings = tempDict;
    [tempDict release];	
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:DaySelectedForTwoWeekSchedule] < 1)
    {
    	[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:DaySelectedForTwoWeekSchedule];
    }
     if (![[NSUserDefaults standardUserDefaults] integerForKey:WorkScheduleSelected])
    {
    	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:WorkScheduleSelected];  // 0 is 7day and 1 is 14day
    }
     if ([[[NSUserDefaults standardUserDefaults] arrayForKey:DaysForTwoWeekSchedule] count] < 1)
    {
        NSMutableArray* temp = [NSMutableArray arrayWithCapacity:14];
        for (int i = 0;i<14;i++)
        {
        	[temp addObject:@"No"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:temp forKey:DaysForTwoWeekSchedule];
    }

	
}

-(void) savesettings {
	BOOL ok = [self.settings writeToFile:[GlobalMethods dataFilePathofDocuments:@"Settings.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"savesettings did not save!");}
}

// workdays /////////////////////////////
-(void)loadworkdays {
	NSMutableArray *preloadworkdays = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"Workdays.plist"]];
	self.workdays = preloadworkdays;
	[preloadworkdays release];
}

//shift days defaults NSUsderDefaults

-(void) saveworkdays {
	BOOL ok = [self.workdays writeToFile:[GlobalMethods dataFilePathofDocuments:@"Workdays.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"saveworkdays did not save!");}
}


// manual workdays ///////////////////////
-(void)loadmanualworkdays {
	NSMutableArray *preloadmanualworkdays = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"ManualWorkdays.plist"]];
	self.manualworkdays = preloadmanualworkdays;
	[preloadmanualworkdays release];
}

-(void) savemanualworkdays {
	BOOL ok = [self.manualworkdays writeToFile:[GlobalMethods dataFilePathofDocuments:@"ManualWorkdays.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"savemanualworkdays did not save!");}
}


// holidays /////////////////////////////
-(void)loadHolidayList {
	NSMutableArray *holidays = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"HolidayList.plist"]];

    	NSMutableDictionary *thanksgiving = [[NSMutableDictionary alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofBundle:@"Thanksgiving.plist"]];
    
    NSString* thisYear = @"2017";  //  need to find out how to get this
    NSString* week = [thanksgiving objectForKey:thisYear];
    for (NSMutableDictionary* holiday in holidays)
    {
            if ([[holiday objectForKey:@"name"] isEqualToString:@"Thanksgiving Day"])
            {
                [holiday setObject:week forKey:@"ordinalweekday"];
                
            }
    
    }
    
    
    
	self.holidaylist = holidays;
	[holidays release];
}

-(void)saveHolidayList {
	BOOL ok = [self.holidaylist writeToFile:[GlobalMethods dataFilePathofDocuments:@"HolidayList.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"saveHolidayList did not save!");}
}

//  Background Colors  ///////////////////////
-(void)loadBackgroundColors {
	NSMutableArray *backgroundColorsTemp = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"BackgroundColors.plist"]];
	NSLog(@"path %@",[GlobalMethods dataFilePathofDocuments:@"BackgroundColors.plist"]);
	self.backgroundColors = backgroundColorsTemp;
    if ([self.backgroundColors count] > 7)
    {
    	NSString* backgroundColor = [self.backgroundColors objectAtIndex:7];
        if ([backgroundColor isEqualToString:@"iPhoneStandard"])
        {
        	[self.backgroundColors replaceObjectAtIndex:7 withObject:@"lightgray"];
        }
    }
//	NSLog(@"self.backgroundColors %@",self.backgroundColors);
	[backgroundColorsTemp release];
}

-(void)saveBackgroundColors {
	BOOL ok = [self.backgroundColors writeToFile:[GlobalMethods dataFilePathofDocuments:@"BackgroundColors.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"saveDayColors did not save!");}
}

//// Text Colors /////
-(void)loadTextColors {
	NSMutableArray *textColorsTemp = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"TextColors.plist"]];
	self.textColors = textColorsTemp;
	[textColorsTemp release];
}

-(void)saveTextColors {
	BOOL ok = [self.textColors writeToFile:[GlobalMethods dataFilePathofDocuments:@"TextColors.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"saveTextColors did not save!");}
}

//////////////  Color Settings
-(void)loadColorSettings {
	NSMutableDictionary *colorsSettingsTemp = [[NSMutableDictionary alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"ColorSettings.plist"]];
	self.colorSettings = colorsSettingsTemp;
	[colorsSettingsTemp release];
}

-(void)saveColorSettings {
	BOOL ok = [self.colorSettings writeToFile:[GlobalMethods dataFilePathofDocuments:@"ColorSettings.plist"] atomically:YES];
	if (ok != YES) {NSLog(@"ColorSettings did not save!");}
}


- (UIImage*)imageFromCache:(NSString*)fileName {
	UIImage *image = [self.imageCache objectForKey:fileName];
	
	if (image == nil) {
		image = [UIImage imageWithContentsOfFile:[GlobalMethods dataFilePathofBundle:[NSString stringWithFormat:@"%@.png",fileName]]];
		if (image == nil) {
			image = [UIImage imageWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:[NSString stringWithFormat:@"%@.png",fileName]]];
		}
		if (image) {
			[self.imageCache setObject:image forKey:fileName];
		}
	}
	return image;
}

#pragma mark Badge Update in Background

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = [self updateIconBadge];
    completionHandler(UIBackgroundFetchResultNewData);
}




- (void)dealloc {
	[navigationController release];
	[window release];
	[ settings release];
	[ workdays release];
	[ holidaylist release];
	[ manualworkdays release];
	[ backgroundColors release];
	[ textColors release];
	[ colorSettings release];
	[imageCache release];
	[super dealloc];
}

//    NSDate* eventDate = [NSDate date];
//    NSDate* lastDate;
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpdate"])
//    {
//    	lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpdate"];
//    }
//    else
//    {
//    	lastDate = [[NSDate date] dateByAddingTimeInterval:-60*60*24*2];
//    }
//   	NSTimeInterval howRecent = [eventDate timeIntervalSinceDate:lastDate];
//   	if (howRecent > 60*60*24) {
//        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastUpdate"];
//	    [UIApplication sharedApplication].applicationIconBadgeNumber = [self updateIconBadge];
//   	}





@end

