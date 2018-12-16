//
//  TimeRemaining.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/7/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "TimeRemaining.h"
#import "RetirementCountdownAppDelegate.h"

@implementation TimeRemaining

// Finding Memorial Day
//    NSInteger aGivenYear = 2012 ;
//
//    NSCalendar* calendar = [NSCalendar currentCalendar] ;
//    NSDateComponents* firstMondayInJuneComponents = [NSDateComponents new] ;
//    firstMondayInJuneComponents.month = 6 ;
//    firstMondayInJuneComponents.weekdayOrdinal = 1 ;
//    firstMondayInJuneComponents.weekday = 2 ; //Monday
//    firstMondayInJuneComponents.year = aGivenYear ;
//    NSDate* firstMondayInJune = [calendar dateFromComponents:firstMondayInJuneComponents] ;
//    // --> 2012-06-04
//
//    NSDateComponents* subtractAWeekComponents = [NSDateComponents new] ;
//    subtractAWeekComponents.week = -1 ;
//    NSDate* memorialDay = [calendar dateByAddingComponents:subtractAWeekComponents toDate:firstMondayInJune options:0] ;
//    // --> 2012-05-28



-(NSDateComponents*)getAbsoluteTimeRemaining:(NSDate*)retirementDate {
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today toDate:retirementDate options:0];
	[gregorian release];
	return components;
}


-(NSArray*)getTimeRemainingFor:(NSDate*)retirementDatePlus1 {  // now uses actual retirementdate
	
	RetirementCountdownAppDelegate *appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
	
    NSMutableString* log = [NSMutableString string];
    [log appendFormat:@"retirementDatePlus1= %@ ,\n\n", retirementDatePlus1];

	int workdayCount = 0;
	///////  get total number of workdays in this period  //////////////////////////////////////////////////////////
	
	// get todays comps
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit; 
	NSDateComponents *todayComps = [gregorian components:unitFlags fromDate:today];
	int todayWeekday = [todayComps weekday];
	int todayYear = [todayComps year];
	int todayMonth = [todayComps month];
	int todayDay = [todayComps day];
	NSDate *todayAtMidnight = [gregorian dateFromComponents:todayComps];

	[log appendFormat:@"today=%@,\n todayWeekday=%i,\n todayYear=%i,\n todayMonth=%i,\n todayDay=%i,\n\n", today, todayWeekday,todayYear,todayMonth,todayDay ];
	
    // get retirement comps
	NSCalendar *gregorian2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags2 = NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit; 
	NSDateComponents *rComps = [gregorian2 components:unitFlags2 fromDate:retirementDatePlus1];
	int retirementWeekday = [rComps weekday];
	int retirementYear = [rComps year];
	[gregorian2 release];

	[log appendFormat:@"retirementWeekday=%i,\n retirementYear=%i,\n\n", retirementWeekday, retirementYear];


	NSDateComponents *totalComps = [gregorian components:(NSDayCalendarUnit) fromDate:today toDate:retirementDatePlus1 options:0];
	int days = [totalComps day] + 1; 
	int weeks = days/7;
	[log appendFormat:@"days=%i,\n weeks=%i,\n\n", days, weeks];

/////////////////////////////////
	

	// get number of workdays in period
    
    //if (shiftWork) {
        
        //start date
        //number of weeks
        //shift hours
        //total hours per shift period/week
        
        //how many shift periods b/w now and retirement date
        
        //Multiple number of shift periods by hours per shift period
        
        //First and last shift day of shift period (For loop)
        
        
        
    //}
        
    //else {
        
        int workdaysPerWeek = 0;
        for (NSString *item in appDelegate.workdays) {
            if ([item isEqualToString:@"YES"]) {
                workdaysPerWeek++;
            }
        }
        workdayCount = workdaysPerWeek*weeks;
        [log appendFormat:@"1 appDelegate.workdays: %@,\n\n", appDelegate.workdays];
        [log appendFormat:@"1 workdayCount=%i,\n\n", workdayCount];
        
        // get workdays in remainder
        int remainderWorkdayCount = 0;
        if (retirementWeekday > todayWeekday) {
            while (retirementWeekday > todayWeekday) {
                //			NSLog(@"todayWeekday %i",todayWeekday);
                if ([[appDelegate.workdays objectAtIndex:todayWeekday-1] isEqualToString:@"YES"]) {
                    remainderWorkdayCount++;
                }
                todayWeekday++;
            }
        } else if (retirementWeekday < todayWeekday) {
            while (retirementWeekday != todayWeekday) {
                //		NSLog(@"retirementWeekday %i",retirementWeekday);
                if ([[appDelegate.workdays objectAtIndex:retirementWeekday-1] isEqualToString:@"YES"]) {
                    remainderWorkdayCount++;
                }
                retirementWeekday--;
                if (retirementWeekday == 0) { retirementWeekday = 7;}
            }	
        } 
        
        workdayCount = workdayCount+remainderWorkdayCount;
        [log appendFormat:@"2 remainderWorkdayCount: %i,\n", remainderWorkdayCount];
        [log appendFormat:@"2 workdayCount=%i,\n\n", workdayCount];
            
    //}
    



	// subtract from count for holidays 

	int holidayCount = [GlobalMethods getHolidayCountFromDate:today toDate:retirementDatePlus1 forHolidayList:appDelegate.holidaylist];  // includes both today and retirementDate
	workdayCount = workdayCount - holidayCount;

    [log appendFormat:@"3 holidayCount: %i,\n", holidayCount];
	[log appendFormat:@"3 workdayCount=%i,\n\n", workdayCount];
    
	// adjust count for manual workdays
	NSArray *manualWorkdays = appDelegate.manualworkdays;
	NSDate *manualWorkdayDate;
	for (id manualWorkday in manualWorkdays){
		manualWorkdayDate = [manualWorkday objectAtIndex:0];
		if (([today compare:manualWorkdayDate] == NSOrderedAscending) && ([retirementDatePlus1 compare:manualWorkdayDate] == NSOrderedDescending))  {
			NSString *defaultDayWorkday = [GlobalMethods isWorkday:manualWorkdayDate forWorkdays:appDelegate.workdays];
				if (([defaultDayWorkday isEqualToString:@"YES"]) && ([[manualWorkday objectAtIndex:1] isEqualToString:@"NO"])) { 
				workdayCount--;
			}
				if (([defaultDayWorkday isEqualToString:@"NO"]) && ([[manualWorkday objectAtIndex:1] isEqualToString:@"YES"]))  {
				workdayCount++;
			}
		}	
	}
    
    [log appendFormat:@"4 manualWorkdays: %@,\n", manualWorkdays];
	[log appendFormat:@"4 workdayCount=%i,\n\n", workdayCount];
    
// NSLog(@"workdayCount after manual days off %i",workdayCount);
	// subtract from count for annual days off

	int numberOfYears = retirementYear - todayYear;
	if (numberOfYears == 0) {
		workdayCount = workdayCount - [[appDelegate.settings objectForKey:@"RetirementYearDaysOff"] intValue];
    }
    else if (numberOfYears == 1)
    {
		workdayCount = workdayCount - [[appDelegate.settings objectForKey:@"RetirementYearDaysOff"] intValue];
		workdayCount = workdayCount - [[appDelegate.settings objectForKey:@"ThisYearDaysOff"] intValue];
	}
    else
    {
		workdayCount = workdayCount - [[appDelegate.settings objectForKey:@"RetirementYearDaysOff"] intValue];
		workdayCount = workdayCount - [[appDelegate.settings objectForKey:@"ThisYearDaysOff"] intValue];
		workdayCount = workdayCount - ([[appDelegate.settings objectForKey:@"AllYearsDaysOff"] intValue]*(numberOfYears-1));
    }

    [log appendFormat:@"5 numberOfYears: %i,\n", numberOfYears];
    [log appendFormat:@"5 RetirementYearDaysOff: %@,\n", [appDelegate.settings objectForKey:@"RetirementYearDaysOff"]];
    [log appendFormat:@"5 ThisYearDaysOff: %@,\n", [appDelegate.settings objectForKey:@"ThisYearDaysOff"]];
    [log appendFormat:@"5 AllYearsDaysOff: %@,\n", [appDelegate.settings objectForKey:@"AllYearsDaysOff"]];
	[log appendFormat:@"5 workdayCount=%i,\n\n", workdayCount];


// get seconds for current day if current workday (and not holiday)
	// convert today to today at midnight

	NSString *holidaystatus = [GlobalMethods isHoliday:todayAtMidnight forHolidays:appDelegate.holidaylist];

    [log appendFormat:@"6 holidaystatus: %@,\n\n", holidaystatus];
    
	int totalsecondsleft = 0;
	if (((([[GlobalMethods isWorkday:todayAtMidnight forWorkdays:appDelegate.workdays] isEqualToString:@"YES"]) && ([holidaystatus isEqualToString:@"NO"]))
				|| ([[GlobalMethods isManualWorkday:todayAtMidnight forManualWorkdays:appDelegate.manualworkdays] isEqualToString:@"ManualYES"]))) {
				
		if (![[GlobalMethods isManualWorkday:todayAtMidnight forManualWorkdays:appDelegate.manualworkdays] isEqualToString:@"ManualNO"]) {
			NSDate *beginWorkhours = [appDelegate.settings objectForKey:@"BeginWorkhours"];
			NSDate *endWorkhours = [appDelegate.settings objectForKey:@"EndWorkhours"];
			NSDateComponents *beginTimeComps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:beginWorkhours];
			NSDateComponents *endTimeComps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)  fromDate:endWorkhours];
			beginWorkhours = [gregorian dateFromComponents:beginTimeComps];
			endWorkhours = [gregorian dateFromComponents:endTimeComps];

		// if within workhours; get seconds to end of workhours. 
		// if its within workhours, if before; add to workdayCount, if after; do not add to workdayCount!!
			
			if ([beginWorkhours compare:endWorkhours] == NSOrderedAscending) {
				[beginTimeComps setYear:todayYear];
				[beginTimeComps setMonth:todayMonth];
				[beginTimeComps setDay:todayDay];
				[endTimeComps setYear:todayYear];
				[endTimeComps setMonth:todayMonth];
				[endTimeComps setDay:todayDay];
			} else {
				[beginTimeComps setYear:todayYear];
				[beginTimeComps setMonth:todayMonth];
				[beginTimeComps setDay:todayDay];
				NSDate *tomorrow = [[NSDate date] dateByAddingTimeInterval:(24*60*60)];
				NSDateComponents *tomorrowComponents = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)  fromDate:tomorrow];
				[endTimeComps setYear:[tomorrowComponents year]];
				[endTimeComps setMonth:[tomorrowComponents month]];
				[endTimeComps setDay:[tomorrowComponents day]];	
			}
			beginWorkhours = [gregorian dateFromComponents:beginTimeComps];
			endWorkhours = [gregorian dateFromComponents:endTimeComps];			

			if (([beginWorkhours compare:today] == NSOrderedAscending) && ([endWorkhours compare:today] == NSOrderedDescending)) {
				totalsecondsleft = [endWorkhours timeIntervalSinceNow];
			} else if ([beginWorkhours compare:today] == NSOrderedDescending) {
				workdayCount++;
			}
		}
	}	

	[log appendFormat:@"7 workdayCount=%i,\n\n", workdayCount];


    if ([retirementDatePlus1 timeIntervalSinceDate:[NSDate date]]<0)
    {
    	totalsecondsleft = 0;
        workdayCount = 0;
    }
    
	NSNumber *totalsecondsleftnumber = [[NSNumber alloc] initWithInt:totalsecondsleft];
	NSNumber *workdayCountnumber = [[NSNumber alloc] initWithInt:workdayCount];

    [log appendFormat:@"8 totalsecondsleftnumber: %@,\n", totalsecondsleftnumber];
	[log appendFormat:@"8 workdayCountnumber=%@,\n\n", workdayCountnumber];
    
	NSArray *timeRemaining = [[[NSArray alloc ] initWithObjects:workdayCountnumber,totalsecondsleftnumber,nil] autorelease]; 

	[log appendFormat:@"9 timeRemaining=%@,\n\n", timeRemaining];
    
    
    
	[totalsecondsleftnumber release];
	[workdayCountnumber release];
	[gregorian release];
    
	NSArray *timeRemainingReturned = [[[NSArray alloc] initWithArray:timeRemaining] autorelease];
	
	return timeRemainingReturned;
	
}	


- (void)dealloc {
	[super dealloc];
}

@end
