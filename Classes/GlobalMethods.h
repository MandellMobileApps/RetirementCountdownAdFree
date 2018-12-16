//
//  GlobalMethods.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/9/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalMethods : NSObject {

}



+(NSDate*)getToday;
+(NSDate*)getThisDateAtMidnight:(NSDate*)thisDay;
+(NSString*) nameOfMonthForInt:(int)month;
+(NSString*) nameOfDayForInt:(int)day;
+(NSString*) nameOfOrdinalWeekdayForInt:(int)day;
+(NSInteger)daysinmonth:(NSInteger)month;

+ (NSString *)dataFilePathofDocuments:(NSString *)nameoffile;
+ (NSString *)dataFilePathofBundle:(NSString *)nameoffile;

+(NSString*)isDefaultDayWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays forHolidays:(NSArray*)theseHolidays;
+(NSString*)isWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays;
+(NSString*)isManualWorkday:(NSDate*)date forManualWorkdays:(NSArray*)theseWorkdays;
+(NSArray *)getHolidaysForMonth:(NSInteger)month year:(NSInteger)year forHolidayList:(NSArray*)theseHolidays;
+(NSString*)isHoliday:(NSDate*)date forHolidays:(NSArray*)theseHolidays;
+(int)getHolidayCountFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate forHolidayList:(NSArray*)theseHolidays;


@end
