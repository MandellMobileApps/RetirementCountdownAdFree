//
//  RetirementCountdownAppDelegate.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/14/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "RetirementCountdownAppDelegate.h"
#import "RootViewController.h"
#import "TimeRemaining.h"
#import "TestingMethods.h"
#import "UtilityMethods.h"

#import <BackgroundTasks/BackgroundTasks.h>


@import UserNotifications;

static NSString* TaskID = @"com.mandellmobileapps.localnotification";

@implementation RetirementCountdownAppDelegate




#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
 
//    self.inTestingMode = NO;
//    if (self.inTestingMode)
//    {
//        [TestingMethods CreateDatabases];
//    }
//
    BOOL copySuccess = [self checkForDatabaseInDocuments];
    if (!copySuccess)
    {
         [SQLiteAccess addToTextLog:@"[self checkForDatabaseInDocuments] failed"];
    }
    

   [self requestNotificationPermission];

    if (self.firstLaunch == 1)
    {
        [self addToDebugLog:[NSString stringWithFormat:@"FirstLaunch"]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *pathDoc = [GlobalMethods dataFilePathofDocuments:@"Settings.plist"];
        BOOL success = [fileManager fileExistsAtPath:pathDoc];
        if(success)
        {
            self.needsUpgradeConverstion = 1;
            [self addToDebugLog:[NSString stringWithFormat:@"Transition From Version %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
        }
        else
        {
            // intial setup
            NSDateComponents* comps = [GlobalMethods currentYMDcomponts];

            NSInteger retireYear = comps.year+1;
            NSInteger retireMonth = comps.month;
            NSInteger retireDay = comps.day;

            // set initial retirement date
            NSString *sql = [NSString stringWithFormat:@"UPDATE Settings Set retirementYear = %li, retirementMonth = %li, retirementDay = %li  WHERE id = 1",(long)retireYear,(long)retireMonth,(long)retireDay];
             [SQLiteAccess updateWithSQL:sql];
        }
    }
    

    BOOL showUpgradeNotice = [[NSUserDefaults standardUserDefaults] boolForKey:@"showUpgradeNotice"];
    if (showUpgradeNotice)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showUpgradeNoticeThisTime"];
    }
    
    
    [self transferDefaultImage];
    
    self.window.rootViewController = self.navigationController;
    
   

    
   // [self addColors];
    //[self deleteExistingTable];
   // [self logSettings];
//    [self CreateDatabasesTemp];
//    [self addThanksgivings];
//    [self addHolidays];
   // [self updateDaysInDayTable];


    

    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {

    [self checkDebugCount];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {


}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self addToDebugLog:@"applicationWillEnterForeground"];
    [self.rootViewController refreshRootViewController];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

    
}

-(void)checkDebugCount
{
    NSArray* logs = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM DebugLog"];
    if (logs.count > 500)
    {
        // remove oldest debug logs
        NSString* sql = @"DELETE FROM DebugLog WHERE ROWID IN (SELECT ROWID FROM DebugLog ORDER BY ROWID DESC LIMIT -1 OFFSET 250)";
        [SQLiteAccess deleteWithSQL:sql];
        NSString* message = [NSString stringWithFormat:@"Should be %li log records",logs.count-250];
        [self addToDebugLog:message];
    }

}

-(void)transferDefaultImage
{
    
    NSString *path1 = [GlobalMethods dataFilePathofBundle:@"beach.png"];
    NSString *path2 = [GlobalMethods dataFilePathofDocuments:@"beach.png"];

    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path2])
    {
        NSError* error;
        [fileManager copyItemAtPath:path1 toPath: path2 error:&error];
        if (error != nil)
        {
            [self addToDebugLog:[error localizedDescription]];
        }
    }

    
}

// http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/RuntimeEnvironment/RuntimeEnvironment.html  
// Multitasking makes the relaunching of applications much faster but does not eliminate the launching of applications altogether. As memory becomes constrained, the system purges applications that have not been used recently. Purges can happen at any time and with no notice. It is therefore imperative that applications save user data and any application state when they move to the background. During the next launch cycle, the application should then use that state information to restore the application to its previous state. Restoring the application in this way makes it seem as if the application never quit, which provides continuity and convenience for the user. 
// UIApplicationExitsOnSuspend (Boolean - iOS) specifies that the application should be terminated rather than moved to the background when it is quit. Applications linked against iOS SDK 4.0 or later can include this key and set its value to YES to prevent being automatically opted-in to background execution and application suspension. When the value of this key is YES, the application is terminated and purged from memory instead of moved to the background. If this key is not present, or is set to NO, the application moves to the background as usual.
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    //NSLog(@"Memory Low");
    [self addToDebugLog:@"Memory Warning"];
}



#pragma mark -
#pragma mark Upgrade Methods

-(void)upgradeToSQLVersion
{

    NSDictionary* Settings = [NSDictionary dictionaryWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"Settings.plist"]];
    NSArray* Workdays = [NSArray arrayWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"Workdays.plist"]];
    NSArray* HolidayList = [NSArray arrayWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"HolidayList.plist"]];

    // take care of Settings plist
    NSDateComponents* retireComps = [GlobalMethods YMDFromNSDate:[Settings objectForKey:@"RetirementDate"]];
    NSDateComponents* beginComps = [GlobalMethods HMSFromNSDate:[Settings objectForKey:@"BeginWorkhours"]];
    
    NSDateComponents* endComps = [GlobalMethods HMSFromNSDate:[Settings objectForKey:@"EndWorkhours"]];
    NSMutableString* sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE Settings SET "];
    [sql appendFormat:@" retirementYear = %li,",retireComps.year];
    [sql appendFormat:@" retirementMonth =  %li,",retireComps.month];
    [sql appendFormat:@" retirementDay =  %li,",retireComps.day];
    [sql appendFormat:@" thisYearDaysOff =  %@,",[Settings objectForKey:@"ThisYearDaysOff"]];
    [sql appendFormat:@" otherYearsDaysOff =  %@,",[Settings objectForKey:@"AllYearsDaysOff"]];
    [sql appendFormat:@" retirementYearDaysOff =  %@,",[Settings objectForKey:@"RetirementYearDaysOff"]];

    if (beginComps.hour < 12)
    {
    [sql appendFormat:@" beginWorkAmPm =  0,"];
    }
    else
    {
        [sql appendFormat:@" beginWorkAmPm =  1,"];
        beginComps.hour = beginComps.hour-12;
    }
    [sql appendFormat:@" beginWorkhours =  %li,",beginComps.hour];
    [sql appendFormat:@" beginWorkMinutes =  %li,",beginComps.minute];
    
    if (endComps.hour < 12)
    {
        [sql appendFormat:@" endWorkAmPm =  0,"];
    }
    else
    {
        [sql appendFormat:@" endWorkAmPm =  1,"];
        endComps.hour = endComps.hour-12;
    }
    [sql appendFormat:@" endWorkhours =  %li,",endComps.hour];
    [sql appendFormat:@" endWorkMinutes =  %li,",endComps.minute];
    
    [sql appendFormat:@" endWorkNextDay = 0,"];
    
    
    [sql appendFormat:@" displayOption =  \"%@\",",[Settings objectForKey:@"DisplayOption"]];
    [sql appendFormat:@" currentDisplay = \"%@\"",[Settings objectForKey:@"CurrentDisplay"]];
    [sql appendFormat:@" WHERE id = 1"];
    [SQLiteAccess updateWithSQL:sql];

    NSDictionary* transitionSettings = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM Settings WHERE id = 1"];

    

    // take care of workdays plist
    NSInteger i = 1;
    for (NSString* string in Workdays)
    {
        BOOL isWorkday = [string isEqualToString:@"YES"];
        NSString* workday;
        if (isWorkday)
        {
            workday = [NSString stringWithFormat:@"UPDATE Workdays SET workday = 1 WHERE id = %li",i];
            
        }
        else
        {
            workday = [NSString stringWithFormat:@"UPDATE Workdays SET workday = 0 WHERE id = %li",i];
            
        }
        [SQLiteAccess updateWithSQL:workday];
        
        i++;
    }
    NSArray* transitionWorkday = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Workdays"];


    
    // take care of holidays plist
    NSArray* oldHolidayNames = [NSArray arrayWithObjects:
                               @"New Years Day",
                               @"Martin Luther King Day",
                               @"USA Presidents Day",
                               @"Memorial Day",
                               @"USA Independence Day",
                               @"Labor Day",
                               @"Veterans Day",
                               @"Thanksgiving Day",
                               @"Christmas Eve",
                               @"Christmas",
                               @"Thanksgiving Friday",
                               @"",
                               nil];
    NSArray* newHolidayNames = [NSArray arrayWithObjects:
                               @"New Years Day",
                               @"Martin Luther King Day",
                               @"USA Presidents Day",
                               @"Memorial Day",
                               @"USA Independence Day",
                               @"Labor Day",
                               @"Veterans Day",
                               @"Thanksgiving Day",
                               @"Christmas Eve",
                               @"Christmas",
                               @"Day after Thanksgiving",
                               @"",
                               nil];
    
    for (NSDictionary* holidayDict in HolidayList)
    {
        NSString* currentHolidayName = [holidayDict objectForKey:@"name"];
        
        if ([oldHolidayNames containsObject:currentHolidayName])
        {
            NSInteger index = [oldHolidayNames indexOfObject:currentHolidayName];
            NSString* newHolidayName = [newHolidayNames objectAtIndex:index];
            NSMutableString* sql = [NSMutableString string];
            [sql appendFormat:@"UPDATE Holidays SET"];
            [sql appendFormat:@" day = %@,",[holidayDict objectForKey:@"day"]];
            [sql appendFormat:@" month = %@,",[holidayDict objectForKey:@"month"]];
            [sql appendFormat:@" ordinalweekday = %@,",[holidayDict objectForKey:@"ordinalweekday"]];
            [sql appendFormat:@" selected = %@,",[holidayDict objectForKey:@"selected"]];
            [sql appendFormat:@" weekday = %@",[holidayDict objectForKey:@"weekday"]];
            [sql appendFormat:@" WHERE name = %@",newHolidayName];
    
            
        }
        else
        {
            NSMutableString* sql = [NSMutableString string];
            [sql appendFormat:@"INSERT INTO Holidays (day,month,name,ordinalweekday,selected,weekday,isCustom) Values ("];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"day"]];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"month"]];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"name"]];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"ordinalweekday"]];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"selected"]];
            [sql appendFormat:@"%@,",[holidayDict objectForKey:@"weekday"]];
            [sql appendFormat:@"1)"];
      

        }

    }
    NSArray* transitionHoliday = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM Holidays"];
 
}

// take care of manual plist
-(void)upgradeManualDays
{
    NSArray* oldManualDays = [NSArray arrayWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"ManualWorkdays.plist"]];
    
    for (NSArray* array in oldManualDays)
    {
        NSDate* date = [array objectAtIndex:0];
        NSString* manual = [array objectAtIndex:1];
        NSInteger isManual = 1;
        
        if ([manual isEqualToString:@"NO"])
        {
            isManual = 0;
        }

        NSDateComponents* comps = [GlobalMethods YMDFromNSDate:date];
        
        NSString* thisDaySql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE year = %li AND month = %li AND day = %li ",comps.year,comps.month,comps.day];
        NSDictionary* thisDay = [SQLiteAccess selectOneRowWithSQL:thisDaySql];
        NSInteger isDefaultDay = [[thisDay objectForKey:@"isDefaultWorkday"] integerValue];
        NSInteger overide = 0;
        
        if ((isManual == 0) && (isDefaultDay == 1))
        {
            overide = 1;
        }
        else  if ((isManual == 1) && (isDefaultDay == 0))
        {
            overide = 1;
        }
        
        if (overide == 1)
        {
            NSMutableString* sql= [NSMutableString stringWithFormat:@"UPDATE Days SET isManualWork = 1 WHERE year = %li AND month = %li AND day = %li",comps.year,comps.month,comps.day];
            [SQLiteAccess updateWithSQL:sql];
        }
    }
}

#pragma mark -
#pragma mark Sql Methods



-(void)updateSettingsString:(NSString*)value  forProperty:(NSString*)propertyName
{
    [self.settingsNew setValue:value forKey:propertyName];
    NSString *sql = [NSString stringWithFormat:@"UPDATE Settings Set %@ = \"%@\" WHERE id = 1",propertyName,value];
      [SQLiteAccess updateWithSQL:sql];
    [self refreshSettings];
    [self addToDebugLog:sql];
 
}

-(void)updateSettingsInteger:(NSInteger)value  forProperty:(NSString*)propertyName
{
     [ self.settingsNew setValue:@(value) forKey:propertyName];
    NSString *sql = [NSString stringWithFormat:@"UPDATE Settings Set %@ = %li WHERE id = 1",propertyName,value];
      [SQLiteAccess updateWithSQL:sql];
    [self refreshSettings];
     [self addToDebugLog:sql];
    
}

-(void)insertIntoTable:(NSString*)table forDictionary:(NSDictionary*)dictionary
{
   
    NSString* dtSql = [NSString stringWithFormat:@"PRAGMA table_info('%@')",table];
    NSArray* dataTypes = [SQLiteAccess selectManyRowsWithSQL:dtSql];

    NSMutableArray* dataTypesArray = [NSMutableArray array];

    NSArray* allKeys = [dictionary allKeys];
    NSArray* allValues = [dictionary allValues];
    
    NSMutableString* sql = [NSMutableString string];
    
    [sql appendFormat:@"INSERT INTO %@ (",table];
    NSInteger i = 0;
     for (NSString* key in allKeys)
     {
         for (NSDictionary* item in dataTypes)
         {
             if ([[item objectForKey:@"name"] isEqualToString:key])
             {
                 [dataTypesArray addObject:[item objectForKey:@"type"]];
             }
         }
         [sql appendFormat:@"%@,",key];

         i++;
     }
     sql = [NSMutableString stringWithString:[sql substringToIndex:sql.length - 1]];
    [sql appendFormat:@") VALUES ("];
     NSInteger v = 0;
     for (NSString* value in allValues)
     {
         NSString* dataType = [dataTypesArray objectAtIndex:v];
         if ([dataType containsString:@"text"])
         {
             [sql appendFormat:@"\"%@\",",value];
         }
         else
         {
             [sql appendFormat:@"%@,",value];
         }
         v++;
     }
     sql = [NSMutableString stringWithString:[sql substringToIndex:sql.length - 1]];
     [sql appendString:@")"];
    
     [SQLiteAccess insertWithSQL:sql];

    
}

-(void)updateTable:(NSString*)table forDictionary:(NSDictionary*)dictionary
{
    // @"UPDATE Settings Set retirementYear = %li, retirementMonth = %li, retirementDay = %li  WHERE id = 1
    //   UPDATE Holidays SET ordinalweekday = 0,delete = 0,id = 5,weekday = 0,day = 8,selected = 1,month = 7,name = USA Independence Day WHERE id = 5
  
    
    NSArray* allKeys = [dictionary allKeys];
    NSMutableString* sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE %@ SET ",table];
     for (NSString* key in allKeys)
     {
         [sql appendFormat:@"%@ = %@,",key,[dictionary valueForKey:key]];
     }
     sql = [NSMutableString stringWithString:[sql substringToIndex:sql.length - 1]];
     [sql appendFormat:@" WHERE id = %@",[dictionary valueForKey:@"id"]];
    
     [SQLiteAccess insertWithSQL:sql];

}



#pragma mark -
#pragma mark New Object Methods


-(void)refreshSettings
{
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM Settings WHERE id = 1"];
    NSDictionary* new = [SQLiteAccess selectOneRowWithSQL:sql];
    self.settingsNew = [SettingsNew settingsFromDictionary:new];

}
-(void)updateDaysInDayTable
{

    // reset Days
    NSMutableString* sql = [NSMutableString stringWithFormat:@"UPDATE Days SET "];
    [sql appendFormat:@" isWeekdayWorkday = 0,"];

    [sql appendFormat:@" holidayId = 0,"];
    [sql appendFormat:@" holidayName = \"\","];
    [sql appendFormat:@" isHoliday = 0,"];

    [sql appendFormat:@" isDefaultWorkday = 0,"];
    [sql appendFormat:@" defaultImageName = \"\","];
    [sql appendFormat:@" defaultTextColorIndex = 0,"];

    [sql appendFormat:@" imageName = \"\","];
    [sql appendFormat:@" textColorIndex = 0,"];

    [sql appendFormat:@" isWorkday = 0"];

    [SQLiteAccess updateWithSQL:sql];
 
 
    //Sets default Workdays to isWorkday = 1
    sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE Days SET "];
    
    [sql appendFormat:@"isWeekdayWorkday = 1,"];
    
    [sql appendFormat:@" holidayId = 0,"];
    [sql appendFormat:@" holidayName = \"\","];
    [sql appendFormat:@" isHoliday = 0,"];
    
    [sql appendFormat:@" isDefaultWorkday = 1,"];
    [sql appendFormat:@" defaultImageName = \"%@\",",self.settingsNew.imageNameWorkdays];
    [sql appendFormat:@" defaultTextColorIndex = %li,",self.settingsNew.textColorIndexWorkdays];
    
    [sql appendFormat:@" imageName = \"%@\",",self.settingsNew.imageNameWorkdays];
    [sql appendFormat:@" textColorIndex = %li,",self.settingsNew.textColorIndexWorkdays];
    
    [sql appendFormat:@" isWorkday = 1"];
    [sql appendFormat:@" WHERE "];
    [sql appendFormat:@" weekday IN (SELECT weekday FROM Workdays WHERE workday = 1)"];
    
    [SQLiteAccess updateWithSQL:sql];

    
    sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE Days SET "];
    
    [sql appendFormat:@" isWeekdayWorkday = 0,"];
    [sql appendFormat:@" isRetirement = 0,"];
    
    [sql appendFormat:@" holidayId = 0,"];
    [sql appendFormat:@" holidayName = \"\","];
    [sql appendFormat:@" isHoliday = 0,"];
    
    [sql appendFormat:@" isDefaultWorkday = 0,"];
    [sql appendFormat:@" defaultImageName = \"%@\",",self.settingsNew.imageNameNonWorkdays];
    [sql appendFormat:@" defaultTextColorIndex = %li,",self.settingsNew.textColorIndexNonWorkdays];
    
    [sql appendFormat:@" imageName = \"%@\",",self.settingsNew.imageNameNonWorkdays];
    [sql appendFormat:@" textColorIndex = %li,",self.settingsNew.textColorIndexNonWorkdays];
    
    [sql appendFormat:@" isWorkday = 0"];
    [sql appendFormat:@" WHERE "];
    [sql appendFormat:@" isWeekdayWorkday = 0"];
    
    [SQLiteAccess updateWithSQL:sql];

    
    // Overwrites Workday to = 0, if isHoliday
    NSMutableString* sqlSelectedHolidays = [NSMutableString stringWithFormat:@"SELECT * FROM Holidays WHERE selected = 1"];
    NSArray* selectedHolidays = [SQLiteAccess selectManyRowsWithSQL:sqlSelectedHolidays];

    for (NSDictionary* holiday in selectedHolidays)
    {
        NSString* day = [holiday objectForKey:@"day"];
        NSString* month = [holiday objectForKey:@"month"];
        NSString* name = [holiday objectForKey:@"name"];
        NSString* ordinalweekday = [holiday objectForKey:@"ordinalweekday"];
        NSString* weekday = [holiday objectForKey:@"weekday"];
        NSString* holidayId = [holiday objectForKey:@"id"];
        NSString* imageName = [holiday objectForKey:@"imageName"];
        NSString* textColorIndex = [holiday objectForKey:@"textColorIndex"];
        NSString* isCustom = [holiday objectForKey:@"isCustom"];
        if ([isCustom integerValue] == 1)
        {
            imageName = self.settingsNew.imageNameHoliday;
            textColorIndex = [NSString stringWithFormat:@"%li",self.settingsNew.textColorIndexHoliday];
        }
        
        if ([day integerValue]>0)
        {
            sql = [NSMutableString string];
            [sql appendFormat:@"UPDATE Days SET "];
            
            // [sql appendFormat:@"isWeekdayWorkday = 0,"];  leave as is
            
            [sql appendFormat:@" holidayId = %@,",holidayId];
            [sql appendFormat:@" holidayName =  \"%@\",",name];
            [sql appendFormat:@" isHoliday = 1,"];
            
            [sql appendFormat:@" isDefaultWorkday = 0,"];
            [sql appendFormat:@" defaultImageName = \"%@\",",imageName];
            [sql appendFormat:@" defaultTextColorIndex = %@,",textColorIndex];
            
            [sql appendFormat:@" imageName = \"%@\",",imageName];
            [sql appendFormat:@" textColorIndex = %@,",textColorIndex];
            
            [sql appendFormat:@" isWorkday = 0"];
            [sql appendFormat:@" WHERE "];
            [sql appendFormat:@" month = %@",month];
            [sql appendFormat:@" AND day = %@",day];
            
            [SQLiteAccess updateWithSQL:sql];
            
        }
        else
        {
            
            sql = [NSMutableString string];
            [sql appendFormat:@"UPDATE Days SET "];
            
            // [sql appendFormat:@"isWeekdayWorkday = 0,"];  leave as is
            
            [sql appendFormat:@" holidayId = %@,",holidayId];
            [sql appendFormat:@" holidayName =  \"%@\",",name];
            [sql appendFormat:@" isHoliday = 1,"];
            
            [sql appendFormat:@" isDefaultWorkday = 0,"];
            [sql appendFormat:@" defaultImageName = \"%@\",",imageName];
            [sql appendFormat:@" defaultTextColorIndex = %@,",textColorIndex];
            
            [sql appendFormat:@" imageName = \"%@\",",imageName];
            [sql appendFormat:@" textColorIndex = %@,",textColorIndex];
            
            [sql appendFormat:@" isWorkday = 0"];
            [sql appendFormat:@" WHERE "];
            [sql appendFormat:@" month = %@",month];
             [sql appendFormat:@" AND ordinalweekday = %@",ordinalweekday];
             [sql appendFormat:@" AND weekday = %@",weekday];
            
            [SQLiteAccess updateWithSQL:sql];
  
            
        }
    }
    
      // if retiredate
    sql = [NSMutableString string];
    [sql appendFormat:@"UPDATE Days SET "];
    [sql appendFormat:@" isRetirement = 1,"];
    [sql appendFormat:@" imageName = \"%@\",",self.settingsNew.imageNameRetirement];
    [sql appendFormat:@" textColorIndex = %li",self.settingsNew.textColorIndexRetirement];

    [sql appendFormat:@" WHERE "];
    [sql appendFormat:@" year = %li",self.settingsNew.retirementYear];
    [sql appendFormat:@" AND month = %li",self.settingsNew.retirementMonth];
    [sql appendFormat:@" AND day = %li",self.settingsNew.retirementDay];

    
    
    [SQLiteAccess updateWithSQL:sql];
  
    
    sql = [NSMutableString string];
     [sql appendFormat:@"UPDATE Days SET "];
     
     [sql appendFormat:@" imageName = \"%@\",",self.settingsNew.imageNameManualWorkdays];
     [sql appendFormat:@" textColorIndex = %li,",self.settingsNew.textColorIndexManualWorkdays];
     
     [sql appendFormat:@" isWorkday = 1"];
     [sql appendFormat:@" WHERE "];
     [sql appendFormat:@" isDefaultWorkday = 0"];
    [sql appendFormat:@" AND isManualWork = 1"];
     
     [SQLiteAccess updateWithSQL:sql];

    
    sql = [NSMutableString string];
     [sql appendFormat:@"UPDATE Days SET "];
     
     [sql appendFormat:@" imageName = \"%@\",",self.settingsNew.imageNameManualNonWorkdays];
     [sql appendFormat:@" textColorIndex = %li,",self.settingsNew.textColorIndexManualNonWorkdays];
     
     [sql appendFormat:@" isWorkday = 0"];
     [sql appendFormat:@" WHERE "];
     [sql appendFormat:@" isDefaultWorkday = 1"];
    [sql appendFormat:@" AND isManualWork = 1"];
     
     [SQLiteAccess updateWithSQL:sql];
 

    

    
}






#pragma mark Badge Update in Background

-(void)requestNotificationPermission
{

    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:
             (UNAuthorizationOptionBadge)
       completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self.notificationPermissiongranted = granted;
        [self addToDebugLog:[NSString stringWithFormat:@"requestNotificationPermission granted: %s  -  %@", granted ? "YES" : "NO",error.localizedDescription]];
    }];
    
}



-(void)configure {

    [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:TaskID
                                                          usingQueue:nil
                                                       launchHandler:^(BGTask *task) {
       [self updateIconBadgeInBackground];
    }];
}

-(void)scheduleAppRefresh {

    BGAppRefreshTaskRequest *request = [[BGAppRefreshTaskRequest alloc] initWithIdentifier:TaskID];
    request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:2*60];
    NSError *error = NULL;
    BOOL success = [[BGTaskScheduler sharedScheduler] submitTaskRequest:request error:&error];
    if (!success) {
        [self addToDebugLog:[NSString stringWithFormat:@"Failed to submit request: %@",error]];
    }

}



-(void)updateIconBadge {

    [UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeDaysOff;

}

-(void)updateIconBadgeInBackground {
    // get data from SQL before doing Time Remaining
    TimeRemaining *myTimeRemaining = [[TimeRemaining alloc] init];
    [myTimeRemaining updateTimeRemaining];
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeDaysOff;

}



#pragma mark Debug Array

// create and append
-(void)addToDebugLog:(NSString*)message
{
    NSString* thisMessage = [message stringByReplacingOccurrencesOfString:@"\""withString:@""];
    NSString* dateString = [GlobalMethods debugFormattedTime];
    float timestamp = [GlobalMethods debugTimestamp];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO DebugLog (timestamp,date, Log) Values (%f,\"%@\",\"%@\");",timestamp, dateString,thisMessage];
    [SQLiteAccess insertWithSQL:sql];
}



#pragma mark SQLite

-(BOOL) checkForDatabaseInDocuments
{
    
   
    
    NSString *path1 = [GlobalMethods dataFilePathofBundle:@"Retirement.sqlite"];
    NSString *path2 = [GlobalMethods dataFilePathofDocuments:@"Retirement.sqlite"];

    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path2])
    {
        NSError* error;
        [fileManager copyItemAtPath:path1 toPath: path2 error:&error];
        if (error == nil)
        {
            self.firstLaunch = 1;
                NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [self addToDebugLog:[NSString stringWithFormat:@"First Launch using version %@",version]];
             [[NSUserDefaults standardUserDefaults] setFloat:[version floatValue] forKey:@"version"];
            return YES;
        }
        else
        {
            [SQLiteAccess addToTextLog:[NSString stringWithFormat:@"checkForDatabaseInDocuments Error  %@", [error localizedDescription]]];
             self.firstLaunch = 1;
            return NO;
        }
        
        
    }
    else
    {
        self.firstLaunch = 0;
        float versionPrevious = [[NSUserDefaults standardUserDefaults] floatForKey:@"version"];
        float versionCurrent = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue];
        if (versionPrevious != versionCurrent)
        {
            [self addToDebugLog:[NSString stringWithFormat:@"Upgraded From %.02f to %.02f",versionPrevious,versionCurrent]];
            [[NSUserDefaults standardUserDefaults] setFloat:versionCurrent forKey:@"version"];
        }
    }

    return YES;
}
//
//-(void)checkForNewTables
//{
//    NSMutableString* versionSql = [NSMutableString string];
//    [versionSql appendFormat:@"CREATE TABLE IF NOT EXISTS Versions2 ("];
//    [versionSql appendFormat:@"id integer PRIMARY KEY AUTOINCREMENT NOT NULL,"];
//    [versionSql appendFormat:@"timestamp integer(128),"];
//    [versionSql appendFormat:@"date text(128),"];
//    [versionSql appendFormat:@"version float(128)"];
//    [versionSql appendFormat:@");"];
//    [SQLiteAccess insertWithSQL:versionSql];
//
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSMutableString* checkVersionSql = [NSMutableString string];
//    [checkVersionSql appendFormat:@"SELECT * FROM Versions2 WHERE version = %@",version];
//    NSArray* versions = [SQLiteAccess selectManyRowsWithSQL:checkVersionSql];
//    if (versions.count == 0)
//    {
//
//
//    }
//
//
//
//
//
//
//}


//-(void)CopyNewDatabaseForNewVersion
//{
//    NSDictionary* settings = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM settings"];
//
//    if ([[settings objectForKey:@"version"]integerValue]== 1)
//    {
//
//        NSArray* holidays = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM Holidays WHERE isCustom = 0"];
//        NSArray* holidaysCustom = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM Holidays WHERE isCustom = 1"];
//        NSArray* workdays = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM Workdays"];
//        NSArray* manualDays = [SQLiteAccess selectOneRowWithSQL:@"SELECT * FROM Days WHERE isManualWork = 1"];
//
//    }
//
//}


@end

