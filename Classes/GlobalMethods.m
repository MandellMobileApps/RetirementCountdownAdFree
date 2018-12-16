//
//  GlobalMethods.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/9/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "GlobalMethods.h"
#import "RetirementCountdownAppDelegate.h"


@implementation GlobalMethods




#pragma mark -
#pragma mark Date Methods

///////  today
+(NSDate*)getToday {
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:today];
	NSDate *todayReturn = [gregorian dateFromComponents:comps];
	[gregorian release];
	return todayReturn;
}

+(NSDate*)getThisDateAtMidnight:(NSDate*)thisDay {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit; // | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *todayComps = [gregorian components:unitFlags fromDate:thisDay];
	NSDate *todayAtMidnight = [gregorian dateFromComponents:todayComps];
	[gregorian release];
	return todayAtMidnight;
	

}

+(NSString*) nameOfMonthForInt:(int)month {
	NSString *name = [[[NSString alloc] init] autorelease]; 
	switch(month) {
		case 1:		// January
			name = @"January";
			break;
		case 2:		// February
			name = @"February";
			break;
		case 3:		// March
			name = @"March";
			break;
		case 4:		// April
			name = @"April";
			break;
		case 5:		// May
			name = @"May";
			break;
		case 6:		// June
			name = @"June";
			break;
		case 7:		// July
			name = @"July";
			break;
		case 8:		// August
			name = @"August";
			break;
		case 9:		// September
			name = @"September";
			break;
		case 10:	// October
			name = @"October";
			break;
		case 11:	// November
			name = @"November";
			break;
		case 12:	// December
			name = @"December";
			break;
	}
	return name;
}


+(NSString*) nameOfDayForInt:(int)day {
	NSString *name = [[[NSString alloc] init] autorelease];    
	switch(day) {
		case 1:		
			name = @"Sunday";
			break;
		case 2:		
			name = @"Monday";
			break;
		case 3:		
			name = @"Tuesday";
			break;
		case 4:		
			name = @"Wednesday";
			break;
		case 5:		
			name = @"Thursday";
			break;
		case 6:		
			name = @"Friday";
			break;
		case 7:		
			name = @"Saturday";
			break;
	}
	return name;
}

+(NSString*) nameOfOrdinalWeekdayForInt:(int)day {
	NSString *name = [[[NSString alloc] init] autorelease];   
	switch(day) {
		case 1:		
			name = @"First";
			break;
		case 2:		
			name = @"Second";
			break;
		case 3:		// March
			name = @"Third";
			break;
		case 4:		// April
			name = @"Fourth";
			break;
	}
	return name;
}

+(NSInteger)daysinmonth:(NSInteger)month {
	NSInteger dim = 0;
	switch(month) {
		case 1:		// January
			dim = 31;
			break;
		case 2:		// February
			dim = 28;
			break;
		case 3:		// March
			dim = 31;
			break;
		case 4:		// April
			dim = 30;
			break;
		case 5:		// May
			dim = 31;
			break;
		case 6:		// June
			dim = 30;
			break;
		case 7:		// July
			dim = 31;
			break;
		case 8:		// August
			dim = 31;
			break;
		case 9:		// September
			dim = 30;
			break;
		case 10:	// October
			dim = 31;
			break;
		case 11:	// November
			dim = 30;
			break;
		case 12:	// December
			dim = 31;
			break;
	}
	return dim;
}



#pragma mark -
#pragma mark Path Methods

// filepaths ///////////////////////////////////////
+ (NSString *)dataFilePathofDocuments:(NSString *)nameoffile {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [[[NSString alloc] initWithString:[[paths objectAtIndex:0] stringByAppendingPathComponent:nameoffile]] autorelease];
	return documentsPath;
}

+ (NSString *)dataFilePathofBundle:(NSString *)nameoffile {
	NSString *bundlePath = [[[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:nameoffile]] autorelease];
	return bundlePath;
}


#pragma mark -
#pragma mark Day Methods


+(NSString*)isDefaultDayWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays forHolidays:(NSArray*)theseHolidays {

	NSString *workdayStatus = [self isWorkday:date forWorkdays:theseWorkdays];
	NSString *holidayStatus = [self isHoliday:date forHolidays:theseHolidays];

	NSString *thisDefaultDay = @"";
	if ([workdayStatus isEqualToString:@"YES"] && [holidayStatus isEqualToString:@"NO"]) {
		thisDefaultDay = @"YES";
	}else {
		thisDefaultDay = @"NO";
	}

	NSString *defaultDay = [[[NSString alloc] initWithString:thisDefaultDay] autorelease];
	
	return defaultDay;
	
}

+(NSString*)isWorkday:(NSDate*)date forWorkdays:(NSArray*)theseWorkdays {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [gregorian components:(NSWeekdayCalendarUnit) fromDate:date];
	int dayofweek = [comps weekday];	
	[gregorian release];
	
	
	NSString *thisWorkdayTemp;
	
	if ([[theseWorkdays objectAtIndex:dayofweek - 1] isEqualToString:@"YES"]) {
		thisWorkdayTemp = @"YES";									
	} else {
		thisWorkdayTemp = @"NO";
	}	
	
	NSString *isWorkdayTemp = [[[NSString alloc] initWithString:thisWorkdayTemp] autorelease];
	
	return isWorkdayTemp;
	
}

+(NSString*)isManualWorkday:(NSDate*)date forManualWorkdays:(NSArray*)theseWorkdays {
	
	NSString *ManualWorkdayStatus = @"NO";
	
	if ([theseWorkdays count] > 0) {
		for (id manualWorkday in theseWorkdays) {
			if ([(NSDate*)[manualWorkday objectAtIndex:0] isEqualToDate:date]) {
				if ([[manualWorkday objectAtIndex:1] isEqualToString:@"YES"]) {
					ManualWorkdayStatus = @"ManualYES";	
				} else {
					ManualWorkdayStatus = @"ManualNO";
				}
			} 
		}
	}
	
	NSString *ManualWorkdayStatusReturned = [[[NSString alloc] initWithString:ManualWorkdayStatus] autorelease];
	
	return ManualWorkdayStatusReturned;
}

// holidays for month///////////////////////////////////////
+(NSArray *)getHolidaysForMonth:(NSInteger)month year:(NSInteger)year forHolidayList:(NSArray*)theseHolidays {
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	NSMutableArray *HolidayNames = [[[NSMutableArray alloc] init] autorelease];
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
				[holidayarray release];
			}
		}
	}
	[gregorian release];
	[components release];
	
	
	NSArray *holidayNamesReturned = [[[NSArray alloc] initWithArray:HolidayNames] autorelease];
	
	return holidayNamesReturned;
	
	
	
}



+(NSString*)isHoliday:(NSDate*)date forHolidays:(NSArray*)theseHolidays {
	
	NSString *holidayText =@"NO";
	NSCalendar *gregorianDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *componentsDate = [gregorianDate components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date];
	int month = [componentsDate month];
	int year = [componentsDate year];
	
	NSCalendar *gregorianHoliday = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

	for (id holiday in theseHolidays){
   
		if ([[holiday valueForKey:@"selected"] isEqualToString:@"YES"]){	
			if ([[holiday valueForKey:@"month"]intValue] == month) {
            	NSDateComponents *componentsHoliday = [[NSDateComponents alloc] init];
				if ([[holiday valueForKey:@"day"] intValue] > 0) {
					[componentsHoliday setDay:[[holiday valueForKey:@"day"]intValue]];
					[componentsHoliday setMonth:[[holiday valueForKey:@"month"]intValue]];
					[componentsHoliday setYear:year];
                    
				} else {
					[componentsHoliday setWeekday:[[holiday valueForKey:@"weekday"]intValue]];
					[componentsHoliday setWeekdayOrdinal:[[holiday valueForKey:@"ordinalweekday"]intValue]];
					[componentsHoliday setMonth:[[holiday valueForKey:@"month"]intValue]];
					[componentsHoliday setYear:year];
				}
				NSDate *holidate = [gregorianHoliday dateFromComponents:componentsHoliday];
				if ([holidate compare:date] == NSOrderedSame) {
					holidayText = [holiday valueForKey:@"name"];
				}
                [componentsHoliday release];
			}
		}
	}
	
	[gregorianDate release];
	[gregorianHoliday release];

	
	NSString *holidayTextReturned = [[[NSString alloc] initWithString:holidayText] autorelease];
	
	return holidayTextReturned;
	
}

+(int)getHolidayCountFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate forHolidayList:(NSArray*)theseHolidays {
	
	int holidayCount = 0;
	NSCalendar *gregorianDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *componentsFromDate = [gregorianDate components:(NSYearCalendarUnit) fromDate:fromDate];
	NSDateComponents *componentsToDate = [gregorianDate components:(NSYearCalendarUnit) fromDate:toDate];
	int fromYear = [componentsFromDate year];
	int toYear = [componentsToDate year];
	
	NSCalendar *gregorianHoliday = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *componentsHoliday = [[NSDateComponents alloc] init];
	
	for (int y = fromYear; y <= toYear; y++) {
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
	
	[gregorianDate release];
	[gregorianHoliday release];
	[componentsHoliday release];
	
	return holidayCount;
}


@end
