//
//  Date.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 1/31/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "Date.h"
#import "GlobalMethods.h"
#import "SettingsNew.h"
#import <objc/message.h>

@implementation Date



+ (Date*)dateWithDictionary:(NSDictionary*)dictionary {


    
    Date *thisDate = [[Date alloc]init];
    thisDate.dayId = [[dictionary objectForKey:@"id"] integerValue];
    thisDate.year = [[dictionary objectForKey:@"year"] integerValue];
    thisDate.month = [[dictionary objectForKey:@"month"] integerValue];
    thisDate.day = [[dictionary objectForKey:@"day"] integerValue];
    thisDate.weekday = [[dictionary objectForKey:@"weekday"] integerValue];
    NSString* concatString = [NSString stringWithFormat:@"%04ld%02ld%02ld",thisDate.year,thisDate.month,thisDate.day];
    thisDate.concat = [concatString integerValue];
    thisDate.ordinalWeekday = [[dictionary objectForKey:@"ordinalWeekday"] integerValue];
    thisDate.isWeekdayWorkday = [[dictionary objectForKey:@"isWeekdayWorkday"] integerValue];
 
    thisDate.holidayId = [[dictionary objectForKey:@"holidayId"] integerValue];;
    thisDate.holidayName = [dictionary objectForKey:@"holidayName"];
    thisDate.isHoliday = [[dictionary objectForKey:@"isHoliday"] integerValue];
    
    thisDate.isDefaultWorkday = [[dictionary objectForKey:@"isDefaultWorkday"] integerValue];
    thisDate.defaultImageName = [dictionary objectForKey:@"defaultImageName"];
    thisDate.defaultTextColorIndex = [[dictionary objectForKey:@"defaultTextColorIndex"] integerValue];
    
    thisDate.isManualWork = [[dictionary objectForKey:@"isManualWork"] integerValue];
    thisDate.isWorkday = [[dictionary objectForKey:@"isWorkday"] integerValue];

    thisDate.isRetirement = [[dictionary objectForKey:@"isRetirement"] integerValue];
    
    thisDate.weekdayName = [dictionary objectForKey:@"weekdayName"];
    thisDate.monthName = [dictionary objectForKey:@"monthName"];

    thisDate.imageName = [dictionary objectForKey:@"imageName"];
    thisDate.textColorIndex = [[dictionary objectForKey:@"textColorIndex"] integerValue];
    



    return thisDate;
}


- (NSDictionary *)toDictionary {
unsigned int count = 0;
NSMutableDictionary *dictionary = [NSMutableDictionary new];
objc_property_t *properties = class_copyPropertyList([self class], &count);
for (int i = 0; i < count; i++) {
NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
id value = [self valueForKey:key];
if (value == nil) {

        }
else if ([value isKindOfClass:[NSNumber class]]
            || [value isKindOfClass:[NSString class]]
            || [value isKindOfClass:[NSDictionary class]]) {

            [dictionary setObject:value forKey:key];
        }
else if ([value isKindOfClass:[NSObject class]]) {
            [dictionary setObject:[value toDictionary] forKey:key];
        }
else {
NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        }
    }
free(properties);
return dictionary;
}


//-(void)workdayCount
//{
//    self.isWorkDay = NO;
//
//    if ((self.isDefaultWorkDay)&&(self.isHoliday==NO))
//    {
//        self.isWorkDay = YES;
//    }
//
//    if ((self.isManualOverride)&&(self.isManualWork))
//    {
//        self.isWorkDay = NO;
//    }
//    else if (self.isDefaultWorkDay==NO)
//    {
//        if ((self.isManualOverride)&&(self.isManualWork==NO))
//        {
//            self.isWorkDay = YES;
//        }
//    }
//
//}





@end
