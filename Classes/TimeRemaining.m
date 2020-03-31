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


-(void)updateTimeRemaining
{
    self.appDelegate = (RetirementCountdownAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    
    NSInteger todayYear = [GlobalMethods currentYear];
    NSInteger todayMonth = [GlobalMethods currentMonth];
    NSInteger todayDay = [GlobalMethods currentDay];
    NSInteger retireYear = self.appDelegate.settingsNew.retirementYear;
    NSInteger retireMonth = self.appDelegate.settingsNew.retirementMonth;
    NSInteger retireDay = self.appDelegate.settingsNew.retirementDay;

    
    NSInteger beginHours = self.appDelegate.settingsNew.beginWorkhours;
    NSInteger beginMinutes = self.appDelegate.settingsNew.beginWorkMinutes;
    NSInteger beginAM = self.appDelegate.settingsNew.beginWorkAmPm;
    NSInteger endHours = self.appDelegate.settingsNew.endWorkhours;
    NSInteger endMinutes = self.appDelegate.settingsNew.endWorkMinutes;
    NSInteger endAM = self.appDelegate.settingsNew.endWorkAmPm;
   // NSInteger nextDay = self.appDelegate.settingsNew.endWorkNextDay;
    NSInteger thisYearOff = self.appDelegate.settingsNew.thisYearDaysOff;
    NSInteger otherOff = self.appDelegate.settingsNew.otherYearsDaysOff;
    NSInteger retireOff = self.appDelegate.settingsNew.retirementYearDaysOff;
    
    
    NSString* todayString = [NSString stringWithFormat:@"%04ld%02ld%02ld",(long)todayYear,(long)todayMonth,(long)todayDay];
    NSString* todaySql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE concat = %@",todayString];
    NSDictionary* todayDict  = [SQLiteAccess selectOneRowWithSQL:todaySql];
    
    NSInteger startConcat = [[todayDict objectForKey:@"concat"]integerValue];
    
    NSString* retireString = [NSString stringWithFormat:@"%04ld%02ld%02ld",(long)retireYear,(long)retireMonth,retireDay];
    NSString* retireSql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE concat = %@",retireString];
    NSDictionary* retireDict  = [SQLiteAccess selectOneRowWithSQL:retireSql];
    NSInteger endConcat = [[retireDict objectForKey:@"concat"]integerValue];

    NSString* monthSql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE concat BETWEEN %li AND %li AND isWorkday= 1",startConcat,endConcat];
    NSArray* totalDays = [SQLiteAccess selectManyRowsWithSQL:monthSql];
    
    
    // JON TEST
   // [self logDays:startConcat end:endConcat];
    
//    NSDate *todayDate = [GlobalMethods todayNsDateNoTime];
//    DLog(@"todayDate %@",todayDate);
//    NSDate *beginDate = [GlobalMethods nsDateFromYear:2020 month:3 day:7];
//     DLog(@"beginDate %@",beginDate);
//    NSDate *endDate = [GlobalMethods nsDateFromYear:2020 month:3 day:10];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    calendar.timeZone = [NSTimeZone localTimeZone];
//    NSInteger unitFlags1 = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *testComps = [calendar components:unitFlags1 fromDate:beginDate  toDate:endDate  options:0];
//
//    DLog(@"testComps %@",testComps);
    

   NSInteger totalWorkdays = totalDays.count;
   
    // initialize and add day cells and corresponding buttons

    // is Today Working?
    NSInteger workingToday = [[todayDict objectForKey:@"isWorkday"]integerValue];
    
    
//    NSInteger startWorkWasYesterday = self.appDelegate.settingsNew.endWorkNextDay;
//
//    if (startWorkWasYesterday == 1)
//    {
//        // is beging seconds > 24 hours
//
//
//
//
//
//    }
//    else
    
    
    
    
    
    // will this fix secondsLeftToday not being reset for a non-workday????
    self.appDelegate.secondsLeftToday = 0;
    
    if (workingToday == 1)
    {

        NSInteger nowSecondsFromMidnight = [GlobalMethods secondsFromMidnightNow];
        NSInteger beginSecondsFromMidnight = [GlobalMethods secondsFromMidnightForHours:beginHours minutes:beginMinutes seconds:0 ampm:beginAM plusDays:0];
       NSInteger endSecondsFromMidnight = [GlobalMethods secondsFromMidnightForHours:endHours minutes:endMinutes seconds:0 ampm:endAM plusDays:0];
        
        if ((nowSecondsFromMidnight>beginSecondsFromMidnight) &&
            (nowSecondsFromMidnight<endSecondsFromMidnight))
        {

            self.appDelegate.secondsLeftToday = endSecondsFromMidnight - nowSecondsFromMidnight;
            totalWorkdays--;
        }
        else if (nowSecondsFromMidnight>endSecondsFromMidnight)
        {
            self.appDelegate.secondsLeftToday = 0;
         
            totalWorkdays--;
        }
        else  //before work starts
        {
            self.appDelegate.secondsLeftToday = 0;
        }

    }
    
        //  totalAnnualDaysOff **********************************************************
    NSInteger totalAnnualDaysOff = 0;

    for (NSInteger i=todayYear;i<=retireYear;i++)
     {

         if (todayYear > retireYear)
         {
              totalAnnualDaysOff = 0;
         }
         else if (todayYear == retireYear)
         {
              totalAnnualDaysOff = retireOff;
         }
         else if (i==todayYear)
         {
             
             totalAnnualDaysOff = totalAnnualDaysOff+thisYearOff;
         }
         else if (i==retireYear)
         {
            totalAnnualDaysOff = totalAnnualDaysOff+retireOff;
         }
         else
         {
             totalAnnualDaysOff = totalAnnualDaysOff+otherOff;
         }
     }
   
    totalWorkdays = totalWorkdays - totalAnnualDaysOff;
  

     self.appDelegate.totalWorkdays = totalWorkdays;
    self.appDelegate.totalAnnualDaysOff = totalAnnualDaysOff;
    
    
     //  Update Calendar Days Left **********************************************************
    
    NSDateComponents* comps = [GlobalMethods calendarTimeLeftToRetirementYear:retireYear month:retireMonth day:retireDay];
        

    self.appDelegate.calendarYearsLeft = comps.year;
    self.appDelegate.calendarMonthsLeft = comps.month;
    self.appDelegate.calendarDaysLeft = comps.day;

    
    NSInteger calendarDaysLeft = [GlobalMethods calendarDaysLeftToRetirementYear:retireYear month:retireMonth day:retireDay];
    
    if ([self.appDelegate.settingsNew.displayOption isEqualToString:@"Work"])
    {
        self.appDelegate.badgeDaysOff = totalWorkdays;
    }
    else if ([self.appDelegate.settingsNew.displayOption isEqualToString:@"Calendar"])
    {
        self.appDelegate.badgeDaysOff = calendarDaysLeft;
    }
    else
    {
         self.appDelegate.badgeDaysOff = 0;
    }

    [self.appDelegate updateIconBadge];

    
         //  End Update Calendar Days Left **********************************************************
    
    
//  Debug Log **********************************************************

    
    [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"Time Period  %li  to %li",startConcat,endConcat] ofType:DebugLogTypeTime];
    [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"Workdays %li,  AnnualDays %li, BadgeDays %li", self.appDelegate.totalWorkdays,self.appDelegate.totalAnnualDaysOff,self.appDelegate.badgeDaysOff] ofType:DebugLogTypeTime];
    
    if (self.appDelegate.secondsLeftToday > 0)
    {
        NSInteger secondsLeftTemp = self.appDelegate.secondsLeftToday % 60;
        NSInteger minutesleftTemp = secondsLeftTemp / 60;
        NSInteger hoursleftTemp = minutesleftTemp / 60;
        minutesleftTemp = minutesleftTemp % 60;
    [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"Today hours %li,  minutes %li, seconds %li", hoursleftTemp,minutesleftTemp,secondsLeftTemp] ofType:DebugLogTypeTime];
        
    }
    
    
    [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"CalendarYears %li, Months %li, Days %li", self.appDelegate.calendarYearsLeft,self.appDelegate.calendarMonthsLeft,self.appDelegate.calendarDaysLeft] ofType:DebugLogTypeTime];


}




-(void)logDays:(NSInteger)start end:(NSInteger)end
{
    
    NSString* monthSql = [NSString stringWithFormat:@"SELECT * FROM Days WHERE concat BETWEEN %li AND %li",start,end];
    NSArray* totalDays = [SQLiteAccess selectManyRowsWithSQL:monthSql];
    
    
    NSMutableString* string = [NSMutableString string];
    [string appendFormat:@"Day,"];
    [string appendFormat:@"isWeekdayWorkday,"];
    [string appendFormat:@"isHoliday,"];
    [string appendFormat:@"isDefaultWorkday,"];
    [string appendFormat:@"isManualWork,"];
    [string appendFormat:@"isWorkday\n"];
    
    for (NSDictionary* item in totalDays)
    {
        [string appendFormat:@"%@,",[item objectForKey:@"concat"]];
        [string appendFormat:@"%@,",[item objectForKey:@"isWeekdayWorkday"]];
        [string appendFormat:@"%@,",[item objectForKey:@"isHoliday"]];
        [string appendFormat:@"%@,",[item objectForKey:@"isDefaultWorkday"]];
        [string appendFormat:@"%@,",[item objectForKey:@"isManualWork"]];
        [string appendFormat:@"%@\n",[item objectForKey:@"isWorkday"]];
    }
    NSLog (@"%@",string);
    
}



@end

