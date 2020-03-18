//
//  GlobalMethods.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/9/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "GlobalMethods.h"
#import "RetirementCountdownAppDelegate.h"
//#import "SettingsNew.h"
#import "SQLiteAccess.h"
//#import "MGDate.h"



@implementation GlobalMethods




#pragma mark -
#pragma mark Date Methods





+(NSString*) fullImageNameFor:(NSString*)imageName
{
    NSString* fullName = [NSString stringWithFormat:@"%@.png",imageName];
    return fullName;

}

+(UIColor*)colorForIndex:(NSInteger)index
{
   
//    + (UIColor *)colorWithWhite:(CGFloat)white
//    alpha:(CGFloat)alpha;
//    if (index == 0)
//    {
//        return [UIColor lightGrayColor];
//
//    }
    

    NSDictionary* dict = [SQLiteAccess selectOneRowWithSQL:[NSString stringWithFormat:@"SELECT * FROM Colors WHERE id = %li",index]];
    
    float red = [[dict objectForKey:@"red"] floatValue];
    float green = [[dict objectForKey:@"green"] floatValue];
    float blue = [[dict objectForKey:@"blue"] floatValue];

     return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];

    
}

+(NSDate*)todayNsDate {
    
//    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
//    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter3 setTimeStyle:NSDateFormatterShortStyle];
//    NSString* dateString = @"Jan 27, 2020 at 9:43 PM";
//    NSDate *todayDate = [dateFormatter3 dateFromString:dateString];
//    return todayDate;
//    [GlobalMethods testCodeWarning];

    
    NSDate* todayNSDate = [NSDate date];
    return todayNSDate;
}

+(NSDate*)todayNsDateNoTime {
    
NSDate* todayNSDate = [GlobalMethods todayNsDate];
 NSCalendar *calendar = [NSCalendar currentCalendar];
 calendar.timeZone = [NSTimeZone localTimeZone];
 NSUInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
NSDateComponents *comps = [calendar components:unitFlags fromDate:todayNSDate];
    comps.second = 0;
    comps.minute = 0;
    comps.hour = 0;
    
    NSDate* thisDate = [calendar dateFromComponents:comps];
    
    return thisDate;
}


+(float) debugTimestamp
{
    NSDate *date = [GlobalMethods todayNsDate];
    NSInteger thisTimestamp = date.timeIntervalSinceReferenceDate;
    float thisFloatTimestamp = thisTimestamp;
    return thisFloatTimestamp;

}


+(NSString*) debugFormattedTime
{
    NSDate *date = [GlobalMethods todayNsDate];
    NSString* formatted = [GlobalMethods dateStringFromDate:date withFormat:DateFormatCustom4];
    return formatted;
}




+(NSString*) formattedDateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString* dateString = [NSString stringWithFormat:@"%@ %li, %li",[GlobalMethods nameOfMonthForInt:month],day,year];
    return dateString;
}





+(NSDate*)nsDateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    NSDate* date = [calendar dateFromComponents:comps];
    return date;

    
}

+(NSDateComponents*)calendarTimeLeftToRetirementYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDate* todayNSDate = [GlobalMethods todayNsDateNoTime];

     NSCalendar *calendar = [NSCalendar currentCalendar];
     calendar.timeZone = [NSTimeZone localTimeZone];
    
    NSDate *startDate = todayNSDate;
    NSDate *endDate = [GlobalMethods nsDateFromYear:year month:month day:day];
    
    NSInteger unitFlags1 = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps1 = [calendar components:unitFlags1 fromDate:startDate  toDate:endDate  options:0];
    
    return comps1;
}

+(NSInteger)calendarDaysLeftToRetirementYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDate* todayNSDate = [GlobalMethods todayNsDateNoTime];
 
     NSCalendar *calendar = [NSCalendar currentCalendar];
     calendar.timeZone = [NSTimeZone localTimeZone];
    
    NSDate *startDate = todayNSDate;
    NSDate *endDate = [GlobalMethods nsDateFromYear:year month:month day:day];
    
    NSInteger unitFlags1 = NSCalendarUnitDay;
    NSDateComponents *comps1 = [calendar components:unitFlags1 fromDate:startDate  toDate:endDate  options:0];
    
    return comps1.day;
}

//+(NSArray*)calendarTimeLeftToRetirementYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
//{
//    NSDate* todayNSDate = [GlobalMethods todayNsDate];
//     NSCalendar *calendar = [NSCalendar currentCalendar];
//     calendar.timeZone = [NSTimeZone localTimeZone];
//
//    NSDate *startDate = todayNSDate;
//    NSDate *endDate = [GlobalMethods nsDateFromYear:year month:month day:day];
//
//    NSInteger unitFlags1 = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *comps1 = [calendar components:unitFlags1 fromDate:startDate  toDate:endDate  options:0];
//    NSInteger yearsLeft = [comps1 year];
//    NSInteger monthsLeft = [comps1 month];
//    NSInteger daysLeft = [comps1 day];
//
//    NSInteger unitFlags2 = NSCalendarUnitDay;
//    NSDateComponents *comps2 = [calendar components:unitFlags2 fromDate:startDate  toDate:endDate  options:0];
//    NSInteger totalDaysLeft = [comps2 day];
//
//    NSNumber* yearsLeftNS = [NSNumber numberWithInteger:yearsLeft];
//    NSNumber* monthsLeftNS = [NSNumber numberWithInteger:monthsLeft];
//    NSNumber* daysLeftNS = [NSNumber numberWithInteger:daysLeft];
//    NSNumber* totalDaysLeftNS = [NSNumber numberWithInteger:totalDaysLeft];
//
//    NSArray* array  = [NSArray arrayWithObjects:
//        yearsLeftNS,
//        monthsLeftNS,
//        daysLeftNS,
//        totalDaysLeftNS,
//    nil];
//
//    return array;
//}


+(NSInteger)secondsFromMidnightNow
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
     NSCalendar *calendar = [NSCalendar currentCalendar];
     calendar.timeZone = [NSTimeZone localTimeZone];
     NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:todayNSDate];
    NSInteger secondsForHours = (comps.hour)*60*60;
    NSInteger secondsForMinutes = (comps.minute)*60;
    NSInteger seconds = comps.second;
    
    NSInteger secondsFromMid = secondsForHours+secondsForMinutes+seconds;
    return secondsFromMid;
 
}
+(NSInteger)secondsFromMidnightForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds ampm:(NSInteger)ampm plusDays:(NSInteger)days
{
    if (ampm == 0)
    {
        if (hours == 12)
        {
            hours = 0;
        }
        
    }
    else if (ampm == 1)
    {
        if (hours > 0)
        {
           if (hours<12)
           {
               hours = hours+12;
           }
        }
        
    }
    
    
    NSInteger secondsForHours = (hours)*60*60;
    NSInteger secondsForMinutes = (minutes)*60;
    NSInteger dayAdder = days*24*60*60;
    NSInteger secondsFromMid = secondsForHours+secondsForMinutes+seconds+dayAdder;
    return secondsFromMid;
    
    
}

+(NSString*)formattedDateStringforCurrentDate
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
     NSCalendar *calendar = [NSCalendar currentCalendar];
     calendar.timeZone = [NSTimeZone localTimeZone];
     NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:todayNSDate];
    
    NSString* dateString = [NSString stringWithFormat:@"%@ %li %li",[GlobalMethods nameOfMonthForInt:comps.month],comps.day,comps.year];
    return dateString;
}

+(NSDateComponents*)currentYMDcomponts
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:todayNSDate];

    return nsDateComps;
}

+(NSInteger)currentYear
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:todayNSDate];

    return nsDateComps.year;
}
+(NSInteger)currentMonth
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitMonth;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:todayNSDate];

    return nsDateComps.month;
}

+(NSInteger)currentDay
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:todayNSDate];

    return nsDateComps.day;
}
+(NSDateComponents*)currentHMS
{
    NSDate* todayNSDate = [GlobalMethods todayNsDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:todayNSDate];

    return nsDateComps;
}

+(NSDateComponents*)HMSFromNSDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:date];

    return nsDateComps;
}

+(NSDateComponents*)YMDFromNSDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nsDateComps = [calendar components:unitFlags fromDate:date];

    return nsDateComps;
}
            
+(void)testCodeWarning
{
          DLog(@"DO NOT RELEASE THIS APP!!!");
          DLog(@"TEST CODE STILL ACTIVE!!!");
}



+(NSInteger)daysinmonth:(NSInteger)month year:(NSInteger)year {
    NSInteger dim;
    dim = 0;
    switch(month) {
        case 1:        // January
            dim = 31;
            break;
        case 2:        // February (check if leap-year)
            dim = ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? 29 : 28;
            break;
        case 3:        // March
            dim = 31;
            break;
        case 4:        // April
            dim = 30;
            break;
        case 5:        // May
            dim = 31;
            break;
        case 6:        // June
            dim = 30;
            break;
        case 7:        // July
            dim = 31;
            break;
        case 8:        // August
            dim = 31;
            break;
        case 9:        // September
            dim = 30;
            break;
        case 10:    // October
            dim = 31;
            break;
        case 11:    // November
            dim = 30;
            break;
        case 12:    // December
            dim = 31;
            break;
    }
    return dim;
}

+(NSString*) nameOfMonthForInt:(NSInteger)month {
    NSString *name = [[NSString alloc] init];
    switch(month) {
        case 1:        // January
            name = @"January";
            break;
        case 2:        // February
            name = @"February";
            break;
        case 3:        // March
            name = @"March";
            break;
        case 4:        // April
            name = @"April";
            break;
        case 5:        // May
            name = @"May";
            break;
        case 6:        // June
            name = @"June";
            break;
        case 7:        // July
            name = @"July";
            break;
        case 8:        // August
            name = @"August";
            break;
        case 9:        // September
            name = @"September";
            break;
        case 10:    // October
            name = @"October";
            break;
        case 11:    // November
            name = @"November";
            break;
        case 12:    // December
            name = @"December";
            break;
    }
    return name;
}

+(NSString*)dayTextForDayofWeek:(NSInteger)weekday
{
    
    NSString* dayText = [NSString string];
    switch (weekday) {
        case 1:
            dayText = @"Sunday";
            break;
        case 2:
            dayText = @"Monday";
            break;
        case 3:
            dayText = @"Tuesday";
            break;
        case 4:
            dayText = @"Wednesday";
            break;
        case 5:
            dayText = @"Thursday";
            break;
        case 6:
            dayText = @"Friday";
            break;
        case 7:
            dayText = @"Saturday";
            break;
        default:
            break;
    }
    return dayText;
    
}
+(NSString*) nameOfOrdinalWeekdayForInt:(NSInteger)day {
    NSString *name = [[NSString alloc] init];
    switch(day) {
        case 1:
            name = @"First";
            break;
        case 2:
            name = @"Second";
            break;
        case 3:        // March
            name = @"Third";
            break;
        case 4:        // April
            name = @"Fourth";
            break;
    }
    return name;
}

#pragma mark -
#pragma mark Path Methods

// filepaths ///////////////////////////////////////
+ (NSString *)dataFilePathofDocuments:(NSString *)nameoffile {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [[NSString alloc] initWithString:[[paths objectAtIndex:0] stringByAppendingPathComponent:nameoffile]];
	return documentsPath;
}

+ (NSString *)dataFilePathofBundle:(NSString *)nameoffile {
	NSString *bundlePath = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:nameoffile]];
	return bundlePath;
}


#pragma mark -
#pragma mark Day Methods


//+(NSString*)isDefaultDayWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays forHolidays:(NSArray*)theseHolidays {
//
//	NSString *workdayStatus = [self isWorkday:date forWorkdays:theseWorkdays];
//	NSString *holidayStatus = [self isHoliday:date forHolidays:theseHolidays];
//
//	NSString *thisDefaultDay = @"";
//	if ([workdayStatus isEqualToString:@"YES"] && [holidayStatus isEqualToString:@"NO"]) {
//		thisDefaultDay = @"YES";
//	}else {
//		thisDefaultDay = @"NO";
//	}
//
//	NSString *defaultDay = [[NSString alloc] initWithString:thisDefaultDay];
//
//	return defaultDay;
//
//}

+(NSString*)isWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comps = [gregorian components:(NSCalendarUnitWeekday) fromDate:date];
	NSInteger dayofweek = [comps weekday];	

	
	
	NSString *thisWorkdayTemp;
	
	if ([[theseWorkdays objectAtIndex:dayofweek - 1] isEqualToString:@"YES"]) {
		thisWorkdayTemp = @"YES";									
	} else {
		thisWorkdayTemp = @"NO";
	}	
	
	NSString *isWorkdayTemp = [[NSString alloc] initWithString:thisWorkdayTemp];
	
	return isWorkdayTemp;
	
}

//+(NSString*)isManualWorkday:(NSDate*)date forManualWorkdays:(NSArray*)theseWorkdays {
//	
//	NSString *ManualWorkdayStatus = @"NO";
//	
//	if ([theseWorkdays count] > 0) {
//		for (id manualWorkday in theseWorkdays) {
//			if ([(NSDate*)[manualWorkday objectAtIndex:0] isEqualToDate:date]) {
//				if ([[manualWorkday objectAtIndex:1] isEqualToString:@"YES"]) {
//					ManualWorkdayStatus = @"ManualYES";	
//				} else {
//					ManualWorkdayStatus = @"ManualNO";
//				}
//			} 
//		}
//	}
//	
//	NSString *ManualWorkdayStatusReturned = [[NSString alloc] initWithString:ManualWorkdayStatus];
//	
//	return ManualWorkdayStatusReturned;
//}

//+(BOOL)isManualOnForThisDate:(NSDate*)date forManualWorkdays:(NSArray*)theseWorkdays {
//    
//    BOOL isManualON = NO;
//    
//    if ([theseWorkdays count] > 0) {
//        for (NSArray* manualWorkday in theseWorkdays) {
//            if ([(NSDate*)[manualWorkday objectAtIndex:0] isEqualToDate:date]) {
//                if ([[manualWorkday objectAtIndex:1] isEqualToString:@"YES"]) {
//                    isManualON = YES;
//                } else {
//                    isManualON = NO;
//                }
//            }
//        }
//    }
//    
//    return isManualON;
//}

//+(SettingsNew*)appSettings
//{
//    RetirementCountdownAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
//    return appDelegate.settingsNew;
//
//}

+(NSInteger)weekdayFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     NSDateComponents *todayComps = [[NSDateComponents alloc] init];
     todayComps.year = year;
     todayComps.month = month;
     todayComps.day = day;
    
     NSDate* nsdate = [calendar dateFromComponents:todayComps];
     NSUInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
     NSDateComponents *newComps = [calendar components:unitFlags fromDate:nsdate];
     return newComps.weekday;
}


// holidays for month///////////////////////////////////////
+(NSArray *)getHolidaysForMonth:(NSInteger)month year:(NSInteger)year forHolidayList:(NSArray*)theseHolidays {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	NSMutableArray *HolidayNames = [[NSMutableArray alloc] init];
	[components setMonth:month];
	[components setYear:year];
	
	for (id holiday in theseHolidays) {
		if ([[holiday valueForKey:@"selected"] isEqualToString: @"YES"]){
			if ([[holiday valueForKey:@"month"] intValue] == month) {
				if ([[holiday valueForKey:@"day"] intValue] > 0) {
					[components setDay:[[holiday valueForKey:@"day"]intValue]];
				}else {
					[components setWeekday:[[holiday valueForKey:@"weekday"]intValue]];
					[components setWeekdayOrdinal:[[holiday valueForKey:@"ordinalweekday"]intValue]];
				}		
				NSDate *holidate = [gregorian dateFromComponents:components];
				NSString *holidayname = [holiday valueForKey:@"name"];
				NSArray *holidayarray = [[NSArray alloc] initWithObjects:holidayname,holidate,nil];
				[HolidayNames addObject:holidayarray];
		
			}
		}
	}

	
	
	NSArray *holidayNamesReturned = [[NSArray alloc] initWithArray:HolidayNames];
	
	return holidayNamesReturned;
	
	
	
}


//
//+(NSString*)isHoliday:(Date*)date forHolidays:(NSArray*)theseHolidays {
//
//    for (id holiday in theseHolidays){
//
//        if ([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]){
//            if ([[holiday valueForKey:@"month"]intValue] == date.month) {
//                if ([[holiday valueForKey:@"day"] intValue] > 0) {
//                    date.isHoliday = YES;
//                } else {
//                    [componentsHoliday setWeekday:[[holiday valueForKey:@"weekday"]intValue]];
//                    [componentsHoliday setWeekdayOrdinal:[[holiday valueForKey:@"ordinalweekday"]intValue]];
//                    [componentsHoliday setMonth:month];
//                    [componentsHoliday setYear:year];
//                }
//                NSDate *holidate = [gregorianHoliday dateFromComponents:componentsHoliday];
//                if ([holidate compare:date] == NSOrderedSame) {
//                    holidayText = @"YES";
//                }
//
//            }
//        }
//    }
//
//
//
//
//    NSString *holidayTextReturned = [[NSString alloc] initWithString:holidayText];
//
//    return holidayTextReturned;
//
//}
//+(NSString*)isHoliday:(NSDate*)date forHolidays:(NSArray*)theseHolidays {
//
//	NSString *holidayText =@"NO";
//	NSCalendar *gregorianDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//	NSDateComponents *componentsDate = [gregorianDate components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
//	NSInteger month = [componentsDate month];
//	NSInteger year = [componentsDate year];
//
//	NSCalendar *gregorianHoliday = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//
//	for (id holiday in theseHolidays){
//
//		if ([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]){
//			if ([[holiday valueForKey:@"month"]intValue] == month) {
//            	NSDateComponents *componentsHoliday = [[NSDateComponents alloc] init];
//				if ([[holiday valueForKey:@"day"] intValue] > 0) {
//					[componentsHoliday setDay:[[holiday valueForKey:@"day"]intValue]];
//					[componentsHoliday setMonth:month];
//					[componentsHoliday setYear:year];
//				} else {
//					[componentsHoliday setWeekday:[[holiday valueForKey:@"weekday"]intValue]];
//					[componentsHoliday setWeekdayOrdinal:[[holiday valueForKey:@"ordinalweekday"]intValue]];
//					[componentsHoliday setMonth:month];
//					[componentsHoliday setYear:year];
//				}
//				NSDate *holidate = [gregorianHoliday dateFromComponents:componentsHoliday];
//				if ([holidate compare:date] == NSOrderedSame) {
//					holidayText = @"YES";
//				}
//
//			}
//		}
//	}
//
//
//
//
//	NSString *holidayTextReturned = [[NSString alloc] initWithString:holidayText];
//
//	return holidayTextReturned;
//
//}

+(NSInteger)getHolidayCountFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate forHolidayList:(NSArray*)theseHolidays {
	
	NSInteger holidayCount = 0;
	NSCalendar *gregorianDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *componentsFromDate = [gregorianDate components:(NSCalendarUnitYear) fromDate:fromDate];
	NSDateComponents *componentsToDate = [gregorianDate components:(NSCalendarUnitYear) fromDate:toDate];
	NSInteger fromYear = [componentsFromDate year];
	NSInteger toYear = [componentsToDate year];
	
	NSCalendar *gregorianHoliday = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *componentsHoliday = [[NSDateComponents alloc] init];
	
	for (NSInteger y = fromYear; y <= toYear; y++) {
		for (id holiday in theseHolidays){
			if([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]){	
				if ([[holiday valueForKey:@"day"] intValue] > 0) {
					[componentsHoliday setDay:[[holiday valueForKey:@"day"]intValue]];
					[componentsHoliday setMonth:[[holiday valueForKey:@"month"]intValue]];
					[componentsHoliday setYear:y];
				}else {
					[componentsHoliday setWeekday:[[holiday valueForKey:@"weekday"]intValue]];
					[componentsHoliday setWeekdayOrdinal:[[holiday valueForKey:@"ordinalweekday"]intValue]];
					[componentsHoliday setMonth:[[holiday valueForKey:@"month"]intValue]];
					[componentsHoliday setYear:y];
				}
				NSDate *holidate = [gregorianHoliday dateFromComponents:componentsHoliday];
				if ((([fromDate compare:holidate] == NSOrderedAscending) && ([toDate compare:holidate] == NSOrderedDescending)) ||
					([fromDate compare:holidate] == NSOrderedSame) || ([toDate compare:holidate] == NSOrderedSame))
				{
					holidayCount = holidayCount + 1;
				}
			}
		}
	}
	
	
	return holidayCount;
}

//+(NSInteger)concatForEasterInYear:(NSInteger)year
//{
//    NSInteger concat = 0;
//    switch (year) {
//        case 15:
//            concat = ;
//            break;
//            
//        default:
//            break;
//    }
//
//
//
//
//    return concat;
//}
//
//+(NSInteger)concatForGoodFridayInYear:(NSInteger)year
//{
//    NSInteger concat = 0;
//    switch (year) {
//        case 15:
//            concat = ;
//            break;
//
//        default:
//            break;
//    }
//
//
//
//
//    return concat;
//}


+(void)setFormatter:(NSDateFormatter*)dateFormatter withFormat:(NSInteger)formatType
{

    switch (formatType) {
        case DateFormatMediumDateMediumTime:;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            dateFormatter.timeStyle = NSDateFormatterMediumStyle;
            break;
        case DateFormatMediumDateNoTime:;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            dateFormatter.timeStyle = NSDateFormatterNoStyle;
            break;
        case DateFormatNoDateMediumTime:;
            dateFormatter.dateStyle = NSDateFormatterNoStyle;
            dateFormatter.timeStyle = NSDateFormatterMediumStyle;
            break;
        case DateFormatShortDateShortTime:;
            dateFormatter.dateStyle = NSDateFormatterShortStyle;
            dateFormatter.timeStyle = NSDateFormatterShortStyle;
            break;
        case DateFormatMediumDateLongTime:;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            dateFormatter.timeStyle = NSDateFormatterLongStyle;
            break;
        case DateFormatNoDateShortTime:;
            dateFormatter.dateStyle = NSDateFormatterNoStyle;
            dateFormatter.timeStyle = NSDateFormatterShortStyle;
            break;
            
        case DateFormatShortDateNoTime:;
            dateFormatter.dateStyle = NSDateFormatterShortStyle;
            dateFormatter.timeStyle = NSDateFormatterNoStyle;
            break;
            
        case DateFormatCustom1:;
            dateFormatter.dateFormat = DateFormatCustom1String;
            break;
        case DateFormatCustom2:;
            dateFormatter.dateFormat = DateFormatCustom2String;
            break;
        case DateFormatCustom3:;
            dateFormatter.dateFormat = DateFormatCustom3String;
            break;
        case DateFormatCustom4:;
            dateFormatter.dateFormat = DateFormatCustom4String;
            break;
        case DateFormatCustom5:;
            dateFormatter.dateFormat = DateFormatCustom5String;
            break;
        case DateFormatCustom6:;
            dateFormatter.dateFormat = DateFormatCustom6String;
            break;
        case DateFormatCustom7:;
            dateFormatter.dateFormat = DateFormatCustom7String;
            break;
        case DateFormatCustom8:;
            dateFormatter.dateFormat = DateFormatCustom8String;
            break;
        case DateFormatCustom9:;
            dateFormatter.dateFormat = DateFormatCustom9String;
            break;
        case DateFormatCustom10:;
            dateFormatter.dateFormat = DateFormatCustom10String;
            break;
        case DateFormatCustom11:;
            dateFormatter.dateFormat = DateFormatCustom11String;
            break;
        case DateFormatCustom12:;
            dateFormatter.dateFormat = DateFormatCustom12String;
            break;
        case DateFormatCustom13:;
            dateFormatter.dateFormat = DateFormatCustom13String;
            break;
        case DateFormatCustom14:;
            dateFormatter.dateFormat = DateFormatCustom14String;
            break;
        case DateFormatCustom15:;
            dateFormatter.dateFormat = DateFormatCustom15String;
            break;
        case DateFormatCustom16:;
            dateFormatter.dateFormat = DateFormatCustom16String;
            break;
        case DateFormatWebrootSubmit:;
            dateFormatter.dateFormat = DateFormatWebrootSubmitString;
            break;
        case DateFormatWebrootReceived:;
            dateFormatter.dateFormat = DateFormatWebrootReceivedString;
            break;
        case DateFormatWebrootDisplay:;
            dateFormatter.dateFormat = DateFormatWebrootDisplayString;
            break;
        case DateFormatWebrootFormTimestamp:;
            dateFormatter.dateFormat = DateFormatWebrootFormTimestampString;
            break;
        case DateFormatWebrootForm:;
            dateFormatter.dateFormat = DateFormatWebrootFormString;
            break;
        default:
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            dateFormatter.timeStyle = NSDateFormatterMediumStyle;
            break;
    }

    
}

+(NSString*)dateFormatStringForFormatType:(NSInteger)formatType
{

    NSString* formatString;
    switch (formatType) {
        case DateFormatMediumDateMediumTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
        case DateFormatMediumDateNoTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
        case DateFormatNoDateMediumTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
        case DateFormatShortDateShortTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
        case DateFormatMediumDateLongTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
        case DateFormatNoDateShortTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
            
        case DateFormatShortDateNoTime:;
            formatString = @"DateFormatMediumDateMediumTime";
            break;
            
        case DateFormatCustom1:;
            formatString = DateFormatCustom1String;
            break;
        case DateFormatCustom2:;
            formatString = DateFormatCustom2String;
            break;
        case DateFormatCustom3:;
            formatString = DateFormatCustom3String;
            break;
        case DateFormatCustom4:;
            formatString = DateFormatCustom4String;
            break;
        case DateFormatCustom5:;
            formatString = DateFormatCustom5String;
            break;
        case DateFormatCustom6:;
            formatString = DateFormatCustom6String;
            break;
        case DateFormatCustom7:;
            formatString = DateFormatCustom7String;
            break;
        case DateFormatCustom8:;
            formatString = DateFormatCustom8String;
            break;
        case DateFormatCustom9:;
            formatString = DateFormatCustom9String;
            break;
        case DateFormatCustom10:;
            formatString = DateFormatCustom10String;
            break;
        case DateFormatCustom11:;
            formatString = DateFormatCustom11String;
            break;
        case DateFormatCustom12:;
            formatString = DateFormatCustom12String;
            break;
        case DateFormatCustom13:;
            formatString = DateFormatCustom13String;
            break;
        case DateFormatCustom14:;
            formatString = DateFormatCustom14String;
            break;
        case DateFormatCustom15:;
            formatString = DateFormatCustom15String;
            break;
        case DateFormatCustom16:;
            formatString = DateFormatCustom16String;
            break;
        case DateFormatCustom17:;
            formatString = DateFormatCustom17String;
            break;
        default:
            formatString = @"Format Not Valid";
            break;
    }
    return formatString;
}

+(NSString*) dateStringFromDate:(NSDate*)thisDate withFormat:(NSInteger)formatType
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [GlobalMethods setFormatter:dateFormatter withFormat:(NSInteger)formatType];
    
    NSString *stringDate = [dateFormatter stringFromDate:thisDate];
    return stringDate;
    
    
}
@end
