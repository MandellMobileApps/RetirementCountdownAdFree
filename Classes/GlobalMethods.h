//
//  GlobalMethods.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/9/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"


enum DateFormat {
    DateFormatMediumDateMediumTime = 0,
    DateFormatMediumDateNoTime = 1,
    DateFormatNoDateMediumTime = 2,
    DateFormatShortDateShortTime = 4,
    DateFormatMediumDateLongTime = 5,
    DateFormatNoDateShortTime = 6,
    DateFormatShortDateNoTime = 7,
    
    DateFormatCustom1 = 11,
    DateFormatCustom2 = 12,
    DateFormatCustom3 = 13,
    DateFormatCustom4 = 14,
    DateFormatCustom5 = 15,
    DateFormatCustom6 = 16,
    DateFormatCustom7 = 17,
    DateFormatCustom8 = 18,
    DateFormatCustom9 = 19,
    DateFormatCustom10 = 20,
    DateFormatCustom11 = 21,
    DateFormatCustom12 = 22,
    DateFormatCustom13 = 23,
    DateFormatCustom14 = 24,
    DateFormatCustom15 = 25,
    DateFormatCustom16 = 26,
    DateFormatCustom17 = 27,
    DateFormatWebrootSubmit = 28,
    DateFormatWebrootReceived = 29,
    DateFormatWebrootDisplay = 30,
    DateFormatWebrootFormTimestamp = 31,
    DateFormatWebrootForm = 32,
    
};
// 9/16/2016 17:29:54
#define DateFormatCustom1String @"MM/dd/yyyy"                           // (06/07/2013)
#define DateFormatCustom2String @"M/d/yyyy h:mm:ss a"                   // (6/7/2013 6:18:57 PM) 10/24/2016  4:42:39 PM
#define DateFormatCustom3String @"MM/dd/yyyy hh:mm:ss a"                // (06/07/2013 06:18:57 PM)
#define DateFormatCustom4String @"MM/dd/yyyy hh:mm:ss.SSS a"                 // "MM/dd/yyyy hh:mm:ss a"    // not used, just put something there so it will not come back as a date for an empty string
#define DateFormatCustom5String @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZ"  //
#define DateFormatCustom6String @"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZ"      //
#define DateFormatCustom7String @"yyyy-MM-dd'T'HH:mm"    // 2016-09-19T09:41:50   // 2016-09-19T09:41:50             // 2014-09-29T11:30:00 for Ticket Custom Fields
#define DateFormatCustom8String @"yyyy-MM-dd'T'HH:mm:ss"                // 2014-05-09T17:15:22.02  for agent procedure initiate
#define DateFormatCustom9String @"E MM/dd"                              //  used on calendar grid
#define DateFormatCustom10String @"yyyy-MM-dd H:mm"                     // used on get group counter logs cpu/mem/disk
#define DateFormatCustom11String @"yyyy-MM-dd'T'HH:mm:ss.SS'+'HH:mm"    //  used for Webroot Form requests
                                // 2017-09-01'T'00:00:00.00'+'00:00  bad
                                // 2016-09-16T17:29:54.00+17:29      good

#define DateFormatCustom12String @"MM_dd_yyyy_HH_mm_ss"                // (6/7/2013 06:18:57 PM)
#define DateFormatCustom13String @"MM/dd"
#define DateFormatCustom14String @"M/d/yyyy HH:mm:ss"
#define DateFormatCustom15String @"M/d/yyyy"
#define DateFormatCustom16String @"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"  // webroot return dates //2016-09-27T06:00:47Z
#define DateFormatCustom17String @"yyyy'-'MM'-'dd"  //2016-09-19
// 5/1/2017
#define DateFormatWebrootSubmitString @"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
#define DateFormatWebrootReceivedString @"yyyy-MM-dd'T'HH:mm:ss.SS'+'HH:mm"
#define DateFormatWebrootDisplayString @"MM/dd/yyyy"
#define DateFormatWebrootFormTimestampString @"M/d/yyyy HH:mm:ss" //timestamp
#define DateFormatWebrootFormString @"M/d/yyyy"

// Date format to submit to Webroot         2016-11-01T23:32:54Z UTC?
// Date format returned from Webroot        2016-11-02T19:34:18.5007293+00:00 UTC
// Date format to store in table Display    11/02/2016 Local Time
// Date format to store in table Epoch      1493614800 UTC


//@class SettingsNew;

@interface GlobalMethods : NSObject {

}
+(NSString*) formattedDateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+(float) debugTimestamp;
+(NSString*) debugFormattedTime;
+(NSDateComponents*)currentYMDcomponts;
+(NSInteger)secondsFromMidnightNow;
//+(NSInteger)secondsFromMidnightForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds plusDays:(NSInteger)days;

+(NSInteger)secondsFromMidnightForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds ampm:(NSInteger)ampm plusDays:(NSInteger)days;

+(NSDateComponents*)calendarTimeLeftToRetirementYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+(NSInteger)calendarDaysLeftToRetirementYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


+(NSInteger)daysinmonth:(NSInteger)month year:(NSInteger)year;
+(NSString*) nameOfMonthForInt:(NSInteger)month;
+(NSString*)dayTextForDayofWeek:(NSInteger)weekday;
+(NSString*) nameOfOrdinalWeekdayForInt:(NSInteger)day;

+ (NSString *)dataFilePathofDocuments:(NSString *)nameoffile;
+ (NSString *)dataFilePathofBundle:(NSString *)nameoffile;


+(NSString*)isWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays;
+(NSString*)isManualWorkday:(NSDate*)date forManualWorkdays:(NSArray*)theseWorkdays;
+(NSArray *)getHolidaysForMonth:(NSInteger)month year:(NSInteger)year forHolidayList:(NSArray*)theseHolidays;
//+(NSString*)isHoliday:(NSDate*)date forHolidays:(NSArray*)theseHolidays;
+(NSInteger)getHolidayCountFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate forHolidayList:(NSArray*)theseHolidays;


+(NSDate*)todayNsDate;
+(NSDate*)todayNsDateNoTime;
+(NSDate*)nsDateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+(NSInteger)currentYear;
+(NSInteger)currentMonth;
+(NSInteger)currentDay;
+(NSDateComponents*)currentHMS;
+(NSDateComponents*)HMSFromNSDate:(NSDate*)date;
+(NSDateComponents*)YMDFromNSDate:(NSDate*)date;
+(NSString*)formattedDateStringforCurrentDate;


+(void)testCodeWarning;

+(NSInteger)weekdayFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


+(UIColor*)colorForIndex:(NSInteger)index;

+(NSString*) fullImageNameFor:(NSString*)imageName;

+(void)setFormatter:(NSDateFormatter*)dateFormatter withFormat:(NSInteger)formatType;
+(NSString*)dateFormatStringForFormatType:(NSInteger)formatType;
+(NSString*) dateStringFromDate:(NSDate*)thisDate withFormat:(NSInteger)formatType;
@end
