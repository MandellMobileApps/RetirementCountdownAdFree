//
//  UtilityMethods.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 2/16/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "UtilityMethods.h"
#import "SQLiteAccess.h"
#import "GlobalMethods.h"
#import "ColorsClass.h"

@implementation UtilityMethods



+(void) deleteExistingTable
{
    
    NSLog(@"deleteExistingTable");
    
     NSString *sql = @"DROP TABLE IF EXISTS Days";
     [SQLiteAccess updateWithSQL:sql];
    
     [UtilityMethods addDays];

}

+(void)addDays
{
    //  Needs to correct field names to match Date.h
    NSInteger year = [GlobalMethods currentYear]-5;
    NSInteger month = [GlobalMethods currentMonth];
    NSInteger day = [GlobalMethods currentDay];
    NSInteger weekday = [GlobalMethods weekdayFromYear:year month:month day:day];
    NSInteger dateConcat = 0 ;
    NSInteger ordinalWeekday = 0 ;
    NSInteger isDefaultWorkDay = 0 ;
    NSInteger isManualOverride = 0 ;
    NSInteger isManualWork = 0 ;
    NSInteger isWorkDay = 0 ;
    NSInteger isHolidayEnabled = 0;
    NSString *holdayName = @"";
    NSString *weekDayText = @"";
    NSString *monthText = @"";
    
    NSInteger max = 365*20;
    NSMutableArray* tempArray = [NSMutableArray array];
    NSInteger d =0;
    for (d=0;d<max;d++)
    {

        //  When DefWorkdays change
        //  When Holdays change
        
        dateConcat = [[NSString stringWithFormat:@"%04ld%02ld%02ld",(long)year,(long)month,(long)day] integerValue];
        ordinalWeekday = ((day-1)/7)+1;
//        NSLog(@"day ordinalWeekday %li    %li",day, ordinalWeekday);
        weekDayText = [GlobalMethods dayTextForDayofWeek:weekday];
        monthText = [GlobalMethods nameOfMonthForInt:month];

        
        NSMutableArray* tempArray2 = [NSMutableArray array];
        
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",year]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",month]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",day]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",weekday]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",dateConcat]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",ordinalWeekday]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",isDefaultWorkDay]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",isManualOverride]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",isManualWork]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",isWorkDay]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",isHolidayEnabled]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%@",holdayName]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%@",weekDayText]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%@",monthText]];
        [tempArray2 addObject:[NSString stringWithFormat:@"%li",d]];

        [tempArray addObject:tempArray2];
         // NSLog(@"%@",tempArray2);
         weekday++;
         if (weekday==8)
         {
             weekday = 1;
         }
        NSInteger daysInMonth = [GlobalMethods daysinmonth:month year:year];
        day++;
        if (day>daysInMonth)
        {
            day = 1;
            month++;
            if (month>12)
            {
                month=1;
                year++;
            }
         }
   
    }
    [UtilityMethods buildNewTableWith:tempArray];

}

+(void)buildNewTableWith:(NSMutableArray*)array
{
    
//    [sql appendFormat:@"year,"];
//    [sql appendFormat:@"month,"];
//    [sql appendFormat:@"day,"];
//    [sql appendFormat:@"weekday,"];
//    [sql appendFormat:@"dateConcat,"];
    
//    [sql appendFormat:@"ordinalWeekday,"];
//    [sql appendFormat:@"isDefaultWorkDay,"];
//    [sql appendFormat:@"isManualOverride,"];
//    [sql appendFormat:@"isManualWork,"];
//    [sql appendFormat:@"isWorkDay,"];
    
//    [sql appendFormat:@"isHolidayEnabled,"];
//    [sql appendFormat:@"holdayName,"];
//    [sql appendFormat:@"weekDayText,"];
//    [sql appendFormat:@"weekDayText,"];
//    [sql appendFormat:@"monthText"];
    
   // NSLog(@"buildNewTable");
    NSMutableString* newSql = [NSMutableString stringWithFormat:@"CREATE TABLE \"Days\" ("];
    
    [newSql appendString:@"\"id\" INTEGER,"];
    [newSql appendString:@"\"year\" INTEGER,"];
    [newSql appendString:@"\"month\" INTEGER,"];
    [newSql appendString:@"\"day\" INTEGER,"];
    [newSql appendString:@"\"weekday\" INTEGER,"];
    [newSql appendString:@"\"dateConcat\" INTEGER,"];
    [newSql appendString:@"\"ordinalWeekday\" INTEGER,"];
    [newSql appendString:@"\"isDefaultWorkDay\" INTEGER,"];
    [newSql appendString:@"\"isManualOverride\" INTEGER,"];
    [newSql appendString:@"\"isManualWork\" INTEGER,"];
    [newSql appendString:@"\"isWorkDay\" INTEGER,"];
    [newSql appendString:@"\"isHolidayEnabled\" INTEGER,"];
    [newSql appendString:@"\"holdayName\" TEXT,"];
    [newSql appendString:@"\"weekDayText\" TEXT,"];
    [newSql appendString:@"\"monthText\" TEXT"];
    
    
    
    [newSql appendString:@" DEFAULT (null) )"];
    //NSLog(@"%@",newSql);
    [SQLiteAccess updateWithSQL:newSql];
 
    NSInteger count= array.count;
        NSInteger i = 0;
        NSInteger start = 0;
        NSInteger thisBlock = 100;
        BOOL complete = NO;
      
        
        while (!complete)
        {
            
            if ((count-start)<100)
            {
                thisBlock = (count-start);
            }
            
            // "BeenThere" TEXT,"StadiumNote" TEXT,"Stadium" TEXT,"RecordId" INTEGER DEFAULT (null) )
            NSMutableString* sql = [NSMutableString string];
 
//            NSInteger year = [GlobalMethods currentYear];
//            NSInteger month = [GlobalMethods currentMonth];
//            NSInteger day = [GlobalMethods currentDay];
//            NSInteger weekday = [GlobalMethods weekdayFromYear:year month:month day:day];
//            NSInteger dateConcat = 0 ;
//            NSInteger ordinalWeekday = 0 ;
//            NSInteger isDefaultWorkDay = 0 ;
//            NSInteger isManualOverride = 0 ;
//            NSInteger isManualWork = 0 ;
//            NSInteger isWorkDay = 0 ;
//            NSInteger isHolidayEnabled = 0;
//            NSString *holdayName = @"";
//            NSString *weekDayText = @"";
//            NSString *monthText = @"";
            
            [sql appendFormat:@"INSERT INTO Days ("];
            
            [sql appendFormat:@"id,"];
            [sql appendFormat:@"year,"];
            [sql appendFormat:@"month,"];
            [sql appendFormat:@"day,"];
            [sql appendFormat:@"weekday,"];
            [sql appendFormat:@"dateConcat,"];
            [sql appendFormat:@"ordinalWeekday,"];
            [sql appendFormat:@"isDefaultWorkDay,"];
            [sql appendFormat:@"isManualOverride,"];
            [sql appendFormat:@"isManualWork,"];
            [sql appendFormat:@"isWorkDay,"];
            [sql appendFormat:@"isHolidayEnabled,"];
            [sql appendFormat:@"holdayName,"];
            [sql appendFormat:@"weekDayText,"];
            [sql appendFormat:@"monthText"];
            
            [sql appendFormat:@") VALUES "];
            
            
            for (i=start; i<(start+thisBlock); i++)
            {

                [sql appendFormat:@"("];
                
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:14]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:0]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:1]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:2]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:3]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:4]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:5]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:6]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:7]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:8]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:9]];
                [sql appendFormat:@"%@,",[[array objectAtIndex:i] objectAtIndex:10]];
                [sql appendFormat:@"\"%@\",",[[array objectAtIndex:i] objectAtIndex:11]];
                [sql appendFormat:@"\"%@\",",[[array objectAtIndex:i] objectAtIndex:12]];
                [sql appendFormat:@"\"%@\"",[[array objectAtIndex:i] objectAtIndex:13]];


                [sql appendString:@"),"];
                
            }
            
            NSString* thisSql1 = [sql substringToIndex:sql.length - 1];
           //NSLog(@"thisSql1 %@",thisSql1);
            [SQLiteAccess insertWithSQL:thisSql1];
            
            // increment new start position
            start = start + thisBlock;
            if (start < (count-1))
            {
                complete = NO;
            }
            else
            {
                complete = YES;
            }
        }
        

    
}

// holidays /////////////////////////////

+(void) CreateDatabasesTemp {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    NSArray *databases = [[NSArray alloc] initWithObjects:
                          @"Settings.plist",
                          @"Settings2.plist",
                          @"ManualWorkdays.plist",
                          @"Workdays.plist",
                          @"HolidayList.plist",
                          @"BackgroundColors.plist",
                          @"TextColors.plist",
                          @"ColorSettings.plist",
                          @"Shiftdays.plist",
                          nil];
    for (NSString *db in databases)
    {
        NSString *pathDoc = [GlobalMethods dataFilePathofDocuments:db];
        success = [fileManager fileExistsAtPath:pathDoc];
        if(!success){
            NSString *pathApp = [GlobalMethods dataFilePathofBundle:db];
            [fileManager copyItemAtPath:pathApp toPath:pathDoc error:nil];
        }

    }

    
    
    
}

+(void)addHolidays
{
    NSMutableArray *holidays = [[NSMutableArray alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofDocuments:@"HolidayList.plist"]];

        NSMutableString* sql = [NSMutableString string];
        [sql appendFormat:@"INSERT INTO Holidays ("];
        
        [sql appendFormat:@"day,"];
        [sql appendFormat:@"month,"];
        [sql appendFormat:@"name,"];
        [sql appendFormat:@"ordinalweekday,"];
        [sql appendFormat:@"selected,"];
        [sql appendFormat:@"weekday"];
             
         [sql appendFormat:@") VALUES "];
         
         for (NSDictionary* holiday in holidays)
         {
             [sql appendFormat:@"("];
             
             [sql appendFormat:@"%@,",[holiday objectForKey:@"day"]];
             [sql appendFormat:@"%@,",[holiday objectForKey:@"month"]];
             [sql appendFormat:@"\"%@\",",[holiday objectForKey:@"name"]];
             [sql appendFormat:@"%@,",[holiday objectForKey:@"ordinalweekday"]];
             [sql appendFormat:@"0,"];
             [sql appendFormat:@"%@",[holiday objectForKey:@"weekday"]];
             [sql appendString:@"),"];
             
         }
         
         NSString* thisSql1 = [sql substringToIndex:sql.length - 1];
        //NSLog(@"thisSql1 %@",thisSql1);
        [SQLiteAccess insertWithSQL:thisSql1];
        
        
}

+(void) addThanksgivings
{
        NSMutableDictionary *thanksgiving = [[NSMutableDictionary alloc] initWithContentsOfFile:[GlobalMethods dataFilePathofBundle:@"Thanksgiving.plist"]];
    NSMutableString* sql = [NSMutableString string];
    
    [sql appendFormat:@"INSERT INTO Thanksgivings ("];
    
    [sql appendFormat:@"year,"];
    [sql appendFormat:@"ordinalweekday"];
     [sql appendFormat:@") VALUES "];
     
    NSArray* years = [thanksgiving allKeys];
    for (NSString* item in years)
     {
         [sql appendFormat:@"("];
         
         [sql appendFormat:@"%@,",item];
         [sql appendFormat:@"%@",[thanksgiving objectForKey:item]];
         [sql appendString:@"),"];
         
     }
     
     NSString* thisSql1 = [sql substringToIndex:sql.length - 1];
    //NSLog(@"thisSql1 %@",thisSql1);
    [SQLiteAccess insertWithSQL:thisSql1];
    
    
}


+(NSString*)checkNull:(id)thisString
{
    if((thisString == [NSNull null]) || ([thisString isEqualToString:@"<NULL>"]) || ([thisString isEqualToString:@"<null>"]) || (!thisString))
    {
        return @"";
    }
    return thisString;

}

+(NSString*)checkIntegers:(id)thisString
{
    if((thisString == [NSNull null]) || ([thisString isEqualToString:@"<NULL>"]) || ([thisString isEqualToString:@"<null>"]) || (!thisString))
    {
        return @"0";
    }
    return thisString;

}

    
+(void)addColors
{
     
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO Colors (id,name,red,green,blue,alpha) VALUES "];
    for (NSInteger c=0;c<494;c++)
    {
        NSString* colorName = [ColorsClass getPredefinedColorNameFor:c];
        UIColor* color = [ColorsClass performSelector:NSSelectorFromString(colorName)];
        const CGFloat* components = CGColorGetComponents(color.CGColor);
        float red = components[0];
        float green = components[1];
        float blue = components[2];

        [sql appendFormat:@"(%li,\"%@\",%.2f,%.2f,%.2f,1.0),",c,colorName,red,green,blue];

        
    }
    NSString* thisSql1 = [sql substringToIndex:sql.length - 1];
    NSLog(@"sql %@",sql);
    
    [SQLiteAccess insertWithSQL:thisSql1];
}
    
    
    
//
//
//    -(void)logSettings
//    {
//        NSLog(@"imageToday %@",self.settingsNew.imageToday);
//        NSLog(@"imageRetirement %@",self.settingsNew.imageRetirement);
//        NSLog(@"imageWorkdays %@",self.settingsNew.imageWorkdays);
//        NSLog(@"imageNonWorkdays %@",self.settingsNew.imageNonWorkdays);
//        NSLog(@"imageHoliday %@",self.settingsNew.imageHoliday);
//        NSLog(@"imageManualWorkdays %@",self.settingsNew.imageManualWorkdays);
//        NSLog(@"imageManualNonWorkdays %@",self.settingsNew.imageManualNonWorkdays);
//
//        NSLog(@"colorTodayText %@",self.settingsNew.colorTodayText);
//        NSLog(@"colorRetirementText %@",self.settingsNew.colorRetirementText);
//        NSLog(@"colorWorkdaysText %@",self.settingsNew.colorWorkdaysText);
//        NSLog(@"colorNonWorkdaysText %@",self.settingsNew.colorNonWorkdaysText);
//        NSLog(@"colorHolidayText %@",self.settingsNew.colorHolidayText);
//        NSLog(@"colorManualWorkdaysText %@",self.settingsNew.colorManualWorkdaysText);
//        NSLog(@"colorManualNonWorkdaysText %@",self.settingsNew.colorManualNonWorkdaysText);
//
//        NSLog(@"colorText %@",self.settingsNew.colorText);
//        NSLog(@"colorBackground %@",self.settingsNew.colorBackground);
//
//
//
//        NSLog(@"currenDisplay %@",self.settingsNew.currenDisplay);
//        NSLog(@"pictureName %@",self.settingsNew.pictureName);
//    }
    

@end
